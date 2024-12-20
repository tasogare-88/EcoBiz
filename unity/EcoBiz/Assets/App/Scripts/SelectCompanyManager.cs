using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using DG.Tweening;
using UnityEngine.UI;
using FlutterUnityIntegration;
using UnityEngine.SceneManagement;

public class SelectCompanyManager : MonoBehaviour, IDragHandler, IBeginDragHandler, IEndDragHandler, IPointerClickHandler
{
    public bool isDebug; // デバッグモードかどうか
    [SerializeField] private RectTransform _placeArea_1; // デフォルトの画面
    [SerializeField] private RectTransform _placeArea_2; // 右にスライドした画面
    [SerializeField] private RectTransform _placeArea_3; // 左にスライドした画面
    [SerializeField] private GameObject[] _buttons; // ボタン
    [SerializeField] private GameObject _companyPrefab; // 会社のPrefab

    private class CompanyData
    {
        public string userId;  // ユーザーID
        public string userName; // ユーザー名
        public string companyName; // 会社名
        public string genre; // 会社のジャンル（"it", "manufacturing", "food", "transport", "advertising", "construction"のいずれか）
        public int locationIndex; // 既存の場所インデックス（初回時はnull）（0はじまり）
        public bool isInitialSetup; // 初回設置かどうか
    }
    private CompanyData _companyData;

    private class LocationData
    {
        public string type;
        public int locationIndex; // 建設場所のインデックス（0はじまり）
    }

    private Vector2 _initialTopBottom; // 初期の画面のTop,Bottomの値
    private float _initialBubblePositionY; // 初期の吹き出しのY座標 
    private Vector2 _offset; // ドラッグ中のオブジェクトの位置を調整するためのオフセット
    private RectTransform[] rectTransforms = new RectTransform[3]; // 移動したいオブジェクトのRectTransform
    private RectTransform[] parentRectTransforms = new RectTransform[3]; // 移動したいオブジェクトの親のRectTransform
    private RectTransform _bubbleRectTransform; // 吹き出しのRectTransform
    private Tweener _clickTween; // 吹き出しクリック時のTweenアニメーション
    
    
    private void Start() 
    {
        rectTransforms[0] = _placeArea_1;
        rectTransforms[1] = _placeArea_2;
        rectTransforms[2] = _placeArea_3;
        
        parentRectTransforms[0] = _placeArea_1.parent as RectTransform;
        parentRectTransforms[1] = _placeArea_2.parent as RectTransform;
        parentRectTransforms[2] = _placeArea_3.parent as RectTransform;

        _initialTopBottom = new Vector2(rectTransforms[0].offsetMax.y, rectTransforms[0].offsetMin.y);

        if(isDebug)
        {
            SetCompanyData("{\"userId\":\"1\",\"userName\":\"user1\",\"companyName\":\"ecobiz\",\"genre\":\"construction\",\"locationIndex\":4,\"isInitialSetup\":true}");
        }
    }

    /// <summary>
    /// 会社IDと建設場所IDを設定
    /// </summary>
    /// <param name="companyId"> 1~6を想定</param>
    /// <param name="locationId">1~9を想定</param>
    /// <param name="isAlreadyBuild"></param> <summary>
    /// 
    /// </summary>
    /// <param name="companyId"></param>
    /// <param name="locationId"></param>
    /// <param name="isAlreadyBuild"></param>
    
    public void LoadScene(string sceneName)
    {
        SceneManager.LoadScene(sceneName);
    }
    public void SetCompanyData(string jsonCompanyData)
    {
        var companyData = JsonUtility.FromJson<CompanyData>(jsonCompanyData);
        _companyData = new CompanyData
        {
            userId = companyData.userId,
            userName = companyData.userName,
            companyName = companyData.companyName,
            genre = companyData.genre,
            locationIndex = companyData.locationIndex,
            isInitialSetup = companyData.isInitialSetup
        };

        if(!_companyData.isInitialSetup)
        {
            // 既に会社が建設されている場合
            // 会社を表示し、その画面に遷移する
            _bubbleRectTransform = GameObject.Find(_companyData.locationIndex.ToString()).transform.GetChild(0).GetComponent<RectTransform>();
            float pointX = _companyData.locationIndex <= 2 ? 1080f : _companyData.locationIndex <= 5 ? 0f : -1080f;
            SetFixedPositions(pointX);
            BuildCompany(_companyData.genre);
            HideSelectCompanyUI(_companyData.locationIndex);
        }
    }

    private void HideSelectCompanyUI(int locationId)
    {
        // 0~8の建設場所をlocationIdの場所以外非表示にする
        for(int i = 0; i <= 8; i++)
        {
            if(i != locationId)
            {
                GameObject.Find(i.ToString()).SetActive(false);
            }
        }

        // ボタンを非表示にする
        // foreach(var button in _buttons)
        // {
        //     button.SetActive(false);
        // }
    }

    # region クリックイベント
    public void OnPointerClick(PointerEventData eventData)
    {
        // クリックしたオブジェクトのタグを確認
        var clickObj = eventData.pointerCurrentRaycast.gameObject;
        if(clickObj.CompareTag("BuildArea") && _clickTween == null)
        {
            // クリックしたオブジェクトがBuildAreaの場合
            _bubbleRectTransform = clickObj.GetComponent<RectTransform>();
            _initialBubblePositionY = _bubbleRectTransform.anchoredPosition.y;
            // 吹き出しのアニメーションを再生
            _clickTween = _bubbleRectTransform.DOAnchorPosY(_initialBubblePositionY + 50f, 0.75f)
            .OnComplete(() => _bubbleRectTransform.DOAnchorPosY(_initialBubblePositionY, 0.75f))
            .SetEase(Ease.OutQuad).SetLoops(-1, LoopType.Yoyo);
            // 建設場所を確定するか確認する
            // 親のオブジェクトの名前から建設場所IDを取得
            _companyData.locationIndex = int.Parse(_bubbleRectTransform.parent.name);
            ConfirmationConstractionLocation(_companyData.locationIndex);
        }
        else if(_clickTween != null)
        {
            _clickTween.Kill();
            _bubbleRectTransform.anchoredPosition = new Vector2(_bubbleRectTransform.anchoredPosition.x, _initialBubblePositionY);
            _clickTween = null;
        }
    }

    private void ConfirmationConstractionLocation(int locationId)
    {
        // 建設場所の確認
        Debug.Log("建設場所を確認");
        var jsonLocationData = BuildCompany(_companyData.genre);
        // Flutter側に建設場所を通知
        UnityMessageManager.Instance.SendMessageToFlutter(jsonLocationData);
        Debug.Log(jsonLocationData);
    }

    private string BuildCompany(string companyGenre)
    {
        // 会社を建設
        Debug.Log("会社を建設");
        RenderTexture newRenderTexture = new RenderTexture(256, 256, 24);
        GameObject company = Instantiate(_companyPrefab, _bubbleRectTransform.position, Quaternion.identity, _bubbleRectTransform.parent);
        company.GetComponent<RectTransform>().rotation = new Quaternion(0, 0, 0, 0);
        company.transform.GetChild(0).GetComponent<Camera>().targetTexture = newRenderTexture;
        var rawImage = company.transform.GetChild(1).GetComponent<RawImage>();
        rawImage.texture = newRenderTexture;

        // 会社IDに応じたモデルを表示
        switch(companyGenre)
        {
            case "it":
            {
                company.transform.GetChild(2).gameObject.SetActive(true);
                break;
            }
            case "manufacturing":
            {
                company.transform.GetChild(3).gameObject.SetActive(true);
                break;
            }
            case "food":
            {
                company.transform.GetChild(4).gameObject.SetActive(true);
                break;
            }
            case "transport":
            {
                company.transform.GetChild(5).gameObject.SetActive(true);
                break;
            }
            case "advertising":
            {
                company.transform.GetChild(6).gameObject.SetActive(true);
                break;
            }
            case "construction":
            {
                company.transform.GetChild(7).gameObject.SetActive(true);
                break;
            }
            default:
            {
                Debug.LogError("会社ジャンルが不正です");
                break;
            }
        }

        _bubbleRectTransform.gameObject.SetActive(false);
        _bubbleRectTransform.parent.GetComponent<Image>().enabled = false;

        string json = JsonUtility.ToJson(new LocationData{type = "COMPANY_PLACE_SELECTED", locationIndex = _companyData.locationIndex}, prettyPrint: true);
        return json;
    }
    #endregion

    # region ドラッグイベント
    public void OnBeginDrag(PointerEventData eventData)
    {
        Vector2 localPointerPosition = GetLocalPosition(eventData.position);
        _offset = rectTransforms[0].anchoredPosition - localPointerPosition;
    }

    public void OnDrag(PointerEventData eventData)
    {
        Vector2 localPointerPosition = GetLocalPosition(eventData.position);
        foreach(var rectTransform in rectTransforms)
        {
            rectTransform.anchoredPosition = localPointerPosition + _offset;
            rectTransform.offsetMax = new Vector2(rectTransform.offsetMax.x, _initialTopBottom.x);
            rectTransform.offsetMin = new Vector2(rectTransform.offsetMin.x, _initialTopBottom.y);
        }
        
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
        // 左右へのスワイプのUIアニメーション
        float pos = GetNearestPositionNumber(pointX);
        foreach (var rectTransform in rectTransforms)
        {
            rectTransform.DOAnchorPosX(pos, 0.5f).SetEase(Ease.OutQuart);
        }
    }

    private float GetNearestPositionNumber(float pointX)
    {
        // どの画面に遷移するかを判断する
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
    #endregion
}
