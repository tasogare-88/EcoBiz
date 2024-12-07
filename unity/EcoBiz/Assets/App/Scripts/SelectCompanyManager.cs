using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.EventSystems;
using DG.Tweening;

public class SelectCompanyManager : MonoBehaviour, IDragHandler, IBeginDragHandler, IEndDragHandler, IPointerClickHandler
{
    [SerializeField] private RectTransform _placeArea_1;
    [SerializeField] private RectTransform _placeArea_2;
    [SerializeField] private RectTransform _placeArea_3;

    private Vector2 _initialTopBottom;
    private Vector2 _offset;
    private RectTransform[] rectTransforms = new RectTransform[3]; // 移動したいオブジェクトのRectTransform
    private RectTransform[] parentRectTransforms = new RectTransform[3]; // 移動したいオブジェクトの親のRectTransform
    private Tweener _clickTween;
    private RectTransform _objRectTransform;
    private float _initialBubblePositionY;
    
    private void Start() 
    {
        rectTransforms[0] = _placeArea_1;
        rectTransforms[1] = _placeArea_2;
        rectTransforms[2] = _placeArea_3;
        
        parentRectTransforms[0] = _placeArea_1.parent as RectTransform;
        parentRectTransforms[1] = _placeArea_2.parent as RectTransform;
        parentRectTransforms[2] = _placeArea_3.parent as RectTransform;

        _initialTopBottom = new Vector2(rectTransforms[0].offsetMax.y, rectTransforms[0].offsetMin.y);
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        // クリックしたオブジェクトの名前を取得
        var clickObj = eventData.pointerCurrentRaycast.gameObject;
        if(clickObj.CompareTag("BuildArea") && _clickTween == null)
        {
            _objRectTransform = clickObj.GetComponent<RectTransform>();
            _initialBubblePositionY = _objRectTransform.anchoredPosition.y;
            _clickTween = _objRectTransform.DOAnchorPosY(_initialBubblePositionY + 50f, 0.75f)
            .OnComplete(() => _objRectTransform.DOAnchorPosY(_initialBubblePositionY, 0.75f))
            .SetEase(Ease.OutQuad).SetLoops(-1, LoopType.Yoyo);
        }
        else if(_clickTween != null)
        {
            _clickTween.Kill();
            _objRectTransform.anchoredPosition = new Vector2(_objRectTransform.anchoredPosition.x, _initialBubblePositionY);
            _clickTween = null;
        }
    }

    public void OnBeginDrag(PointerEventData eventData)
    {
        Vector2 localPointerPosition = GetLocalPosition(eventData.position);
        _offset = rectTransforms[0].anchoredPosition - localPointerPosition;
    }

    public void OnDrag(PointerEventData eventData)
    {
        Vector2 localPointerPosition = GetLocalPosition(eventData.position);
        rectTransforms[0].anchoredPosition = localPointerPosition + _offset;
        rectTransforms[1].anchoredPosition = localPointerPosition + _offset;
        rectTransforms[2].anchoredPosition = localPointerPosition + _offset;

        rectTransforms[0].offsetMax = new Vector2(rectTransforms[0].offsetMax.x, _initialTopBottom.x);
        rectTransforms[0].offsetMin = new Vector2(rectTransforms[0].offsetMin.x, _initialTopBottom.y);
        rectTransforms[1].offsetMax = new Vector2(rectTransforms[1].offsetMax.x, _initialTopBottom.x);
        rectTransforms[1].offsetMin = new Vector2(rectTransforms[1].offsetMin.x, _initialTopBottom.y);
        rectTransforms[2].offsetMax = new Vector2(rectTransforms[2].offsetMax.x, _initialTopBottom.x);
        rectTransforms[2].offsetMin = new Vector2(rectTransforms[2].offsetMin.x, _initialTopBottom.y);
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        SetFixedPositions(rectTransforms[0].anchoredPosition.x);
    }

    // ScreenPositionからlocalPositionへの変換関数
    private Vector2 GetLocalPosition(Vector2 screenPosition)
    {
        Vector2 result = Vector2.zero;

        // screenPositionを親の座標系(parentRectTransform)に対応するよう変換する.
        RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRectTransforms[0], screenPosition, Camera.main, out result);

        return result;
    }

    public void SetFixedPositions(float pointX)
    {
        float pos = GetNearestPositionNumber(pointX);
        rectTransforms[0].DOAnchorPosX(pos, 0.5f).SetEase(Ease.OutQuart);
        rectTransforms[1].DOAnchorPosX(pos, 0.5f).SetEase(Ease.OutQuart);
        rectTransforms[2].DOAnchorPosX(pos, 0.5f).SetEase(Ease.OutQuart);
    }

    private float GetNearestPositionNumber(float pointX)
    {
        float nearestPositionNumber = 0f;
        float min = float.MaxValue;
        float[] comparisonPositionNumbers = new float[] {0f, 1080f, -1080f};

        for (int i = 0; i < comparisonPositionNumbers.Length; i++)
        {
            float diff = Mathf.Abs(pointX - comparisonPositionNumbers[i]);
            if(diff < min)
            {
                min = diff;
                nearestPositionNumber = comparisonPositionNumbers[i];
            }
        }

        return nearestPositionNumber;
    }
}
