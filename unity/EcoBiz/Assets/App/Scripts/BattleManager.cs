using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class BattleManager : MonoBehaviour
{
    [Header("デバッグモード(実行後Startメソッドでバトル開始)")]
    public bool IsDebugMode = false;
    public int MyStep = 0;
    public int OpponentStep = 0;

    [SerializeField] private GameObject _battleUI; // バトルUI

    [SerializeField] private RectTransform _vsLineImage; // VSのライン
    [SerializeField] private RectTransform _vsBGOrange; // VSエリアのオレンジ部分
    [SerializeField] private RectTransform _vsBGBlue; // VSエリアの青部分
    [SerializeField] private RectTransform _vsText; // VSのテキスト
    [SerializeField] private Image _whiteOutImage; // ホワイトアウト用のImage
    [SerializeField] private Slider _myStepGraph; // 自分のステップグラフ
    [SerializeField] private Slider _opponentStepGraph; // 相手のステップグラフ
    [SerializeField] private LineRenderer stepDifferenceLine_Mine; // 自分のグラフから延びるステップ差分のライン
    [SerializeField] private LineRenderer stepDifferenceLine_Opponent; // 相手のグラフから延びるステップ差分のライン

    private void Awake() 
    {
        // _myPlayerName.gameObject.SetActive(false);
        // _opponentPlayerName.gameObject.SetActive(false);
    }

    private void Start() 
    {
        if(IsDebugMode)
        {
            StartBattle();
        }
    }

    public void StartBattle()
    {
        _vsLineImage.gameObject.SetActive(true);
        _vsBGBlue.DOAnchorPos3DX(0, 1.0f).SetEase(Ease.OutQuart);
        _vsBGOrange.DOAnchorPos3DX(0, 1.0f).SetEase(Ease.OutQuart);
        DOVirtual.DelayedCall(1.0f, () => {
            _vsText.gameObject.SetActive(true);
            _vsText.DOScale(Vector3.one, 0.8f).SetEase(Ease.OutBack);
        });
        DOVirtual.DelayedCall(2.5f, () => {
            _whiteOutImage.DOFade(1f, 1.0f);
        });
        DOVirtual.DelayedCall(4.0f, () => {
            StepGraphDraw(MyStep, OpponentStep);
        });

        
    }

    public void StepGraphDraw(int myStep, int opponentStep)
    {
        _battleUI.SetActive(true);
        _whiteOutImage.DOFade(0f, 1.0f);

        int fewerStep = 0;
        int higherStep = 0;
        if(myStep < opponentStep)
        {
            fewerStep = myStep;
            higherStep = opponentStep;
        }
        else if(myStep > opponentStep)
        {
            fewerStep = opponentStep;
            higherStep = myStep;
        }
        else if(myStep == opponentStep)
        {
            return;
        }

        float higherStepValue = 1.0f;
        float fewerStepValue = (float)fewerStep / (float)higherStep;

        _myStepGraph.DOValue(fewerStepValue, 3.0f);
        _opponentStepGraph.DOValue(fewerStepValue, 3.0f);
        DOVirtual.DelayedCall(4.5f, () => {
            _myStepGraph.DOValue(higherStepValue, 0.5f);
            DrawStepDifferenceDashLine(stepDifferenceLine_Mine);
        });
        
    }

    public void DrawStepDifferenceDashLine(LineRenderer stepDifferenceLine)
    {
        stepDifferenceLine.SetPosition(0, stepDifferenceLine.transform.GetChild(0).position);
        stepDifferenceLine.SetPosition(1, stepDifferenceLine.transform.GetChild(1).position);
    }


}
