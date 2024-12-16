using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using Cysharp.Threading.Tasks;

public class BattleManager : MonoBehaviour
{
    [Header("デバッグモード(実行後Startメソッドでバトル開始)")]
    public bool IsDebugMode = false;
    public int MyStep = 0;
    public int OpponentStep = 0;

    [SerializeField] private GameObject _battleUI; // バトルUI

    [SerializeField] private Image _vsLineImage; // VSのライン
    [SerializeField] private RectTransform _vsBGOrange; // VSエリアのオレンジ部分
    [SerializeField] private RectTransform _vsBGBlue; // VSエリアの青部分
    [SerializeField] private RectTransform _myPlayerName; // 自分のプレイヤー名
    [SerializeField] private RectTransform _opponentPlayerName; // 相手のプレイヤー名
    [SerializeField] private RectTransform _vsText; // VSのテキスト
    [SerializeField] private Image _whiteOutImage; // ホワイトアウト用のImage
    [SerializeField] private Slider _myStepGraph; // 自分のステップグラフ
    [SerializeField] private Slider _opponentStepGraph; // 相手のステップグラフ
    [SerializeField] private LineRenderer stepDifferenceLine_Mine; // 自分のグラフから延びるステップ差分のライン
    [SerializeField] private LineRenderer stepDifferenceLine_Opponent; // 相手のグラフから延びるステップ差分のライン
    [SerializeField] private RectTransform _stepDifferenceArrow_Mine; // 自分のグラフから延びるステップ差分の矢印
    [SerializeField] private RectTransform _stepDifferenceArrow_Opponent; // 相手のグラフから延びるステップ差分の矢印
    [SerializeField] private RectTransform _stepDifferenceBubble; // ステップ差分のバブル

    private void Awake() 
    {
        // _myPlayerName.gameObject.SetActive(false);
        // _opponentPlayerName.gameObject.SetActive(false);
    }

    private void Start() 
    {
        _myStepGraph.value = 0;
        _opponentStepGraph.value = 0;
        _stepDifferenceArrow_Mine.gameObject.SetActive(false);
        _stepDifferenceArrow_Opponent.gameObject.SetActive(false);
        _battleUI.SetActive(false);
        if(IsDebugMode)
        {
            StartBattle();
        }
    }

    public async void StartBattle()
    {
        _vsLineImage.DOFade(1f, 0.5f).WaitForCompletion();
        await UniTask.Delay(500);

        _vsBGBlue.DOAnchorPos3DX(0, 1.0f).SetEase(Ease.OutQuart);
        await _vsBGOrange.DOAnchorPos3DX(0, 1.0f).SetEase(Ease.OutQuart)
        .OnComplete(() => {
            _myPlayerName.gameObject.SetActive(true);
            _opponentPlayerName.gameObject.SetActive(true);
            _vsText.gameObject.SetActive(true);
            _vsText.DOScale(Vector3.one, 0.8f).SetEase(Ease.OutBack);
        })
        .AsyncWaitForCompletion();

        await UniTask.Delay(1500);

        await _whiteOutImage.DOFade(1f, 1.0f).AsyncWaitForCompletion();

        await UniTask.Delay(1500);
        StepGraphDraw(MyStep, OpponentStep);
        
    }

    public async void StepGraphDraw(int myStep, int opponentStep)
    {
        _battleUI.SetActive(true);
        _whiteOutImage.DOFade(0f, 1.0f);

        int fewerStep = 0;
        int higherStep = 0;
        Slider stepGraph = null;
        LineRenderer stepDifferenceLine = null;
        RectTransform stepDifferenceArrow = null;
        if(myStep < opponentStep)
        {
            fewerStep = myStep;
            higherStep = opponentStep;
            stepGraph = _opponentStepGraph;
            stepDifferenceLine = stepDifferenceLine_Opponent;
            stepDifferenceArrow = _stepDifferenceArrow_Mine;
            _stepDifferenceBubble.localRotation = Quaternion.Euler(0f, 0f, -90f);
            _stepDifferenceBubble.GetChild(0).GetComponent<RectTransform>().localRotation = Quaternion.Euler(0f, 0f, 0f);
        }
        else if(myStep > opponentStep)
        {
            fewerStep = opponentStep;
            higherStep = myStep;
            stepGraph = _myStepGraph;
            stepDifferenceLine = stepDifferenceLine_Mine;
            stepDifferenceArrow = _stepDifferenceArrow_Opponent;
            _stepDifferenceBubble.localRotation = Quaternion.Euler(0f, 0f, 90f);
            _stepDifferenceBubble.GetChild(0).GetComponent<RectTransform>().localRotation = Quaternion.Euler(0f, 0f, 180f);
        }
        else if(myStep == opponentStep)
        {
            return;
        }

        float higherStepValue = 1.0f;
        float fewerStepValue = (float)fewerStep / (float)higherStep;

        _myStepGraph.DOValue(fewerStepValue, 3.0f);
        await _opponentStepGraph.DOValue(fewerStepValue, 3.0f).AsyncWaitForCompletion();
        
        await UniTask.Delay(1500);
        await stepGraph.DOValue(higherStepValue, 0.5f).AsyncWaitForCompletion();
        DrawStepDifferenceDashLine(stepDifferenceLine, stepDifferenceArrow, fewerStepValue);
        
    }

    public async void DrawStepDifferenceDashLine(LineRenderer stepDifferenceLine, RectTransform stepDifferenceArrow, float fewerStepValue)
    {
        stepDifferenceLine.SetPosition(0, stepDifferenceLine.transform.GetChild(0).position);
        stepDifferenceLine.SetPosition(1, stepDifferenceLine.transform.GetChild(1).position);
        await UniTask.Delay(500);
        if(fewerStepValue <= 0.85f)
        {
            // 最小値50,最大値890で、補正したfewerStepValueの値を0~1の間で変換
            fewerStepValue += (fewerStepValue * 0.16f);
            float stepDifferenceArrowX = Mathf.Lerp(50, 890, fewerStepValue);
            stepDifferenceArrow.offsetMin = new Vector2(stepDifferenceArrowX, stepDifferenceArrow.offsetMin.y);
            stepDifferenceArrow.gameObject.SetActive(true);

            _stepDifferenceBubble.gameObject.SetActive(true);
        }
        
    }


}
