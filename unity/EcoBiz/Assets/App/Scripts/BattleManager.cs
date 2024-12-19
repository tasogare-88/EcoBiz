using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using Cysharp.Threading.Tasks;

public class BattleManager : MonoBehaviour
{
    [Header("デバッグモード(実行後Startメソッドでバトル開始)")]
    public bool IsDebug = false;
    public int userId;
    public int opponentId;
    private bool isMyWin;
    private int totalAssetsClimbRange;
    private int totalAssetsDeclineRange;

    public int myStep;
    public int opponentStep;

    private class ResultData
    {
        public int userId;
        public int opponentId;
        public bool isMyWin;
        public int totalAssetsClimbRange;
        public int totalAssetsDeclineRange;
    }
    private ResultData _resultData = null;

    [SerializeField] private GameObject _battleUI; // バトルUI
    [SerializeField] private GameObject _resultUI; // リザルトUI

    #region VS~バトルUIの各要素
    [Header("VS~バトルUIの各要素")]
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
    [SerializeField] private Text _stepDifferenceText; // ステップ差分のテキスト
    #endregion

    #region バトル結果UIの各要素
    [Header("バトル結果UIの各要素")]
    [SerializeField] private Image _resultBG; // リザルトエリアの背景
    [SerializeField] private Text _resultText; // リザルトテキスト
    [SerializeField] private Text _earningsText; // 収益のテキスト
    #endregion

    public void SetData(int userId, int opponentId, bool isMyWin, int totalAssetsClimbRange, int totalAssetsDeclineRange)
    {
        _resultData = new ResultData
        {
            userId = userId,
            opponentId = opponentId,
            isMyWin = isMyWin,
            totalAssetsClimbRange = totalAssetsClimbRange,
            totalAssetsDeclineRange = totalAssetsDeclineRange
        };
    }

    private void Start() 
    {
        _myStepGraph.value = 0;
        _opponentStepGraph.value = 0;
        _stepDifferenceArrow_Mine.gameObject.SetActive(false);
        _stepDifferenceArrow_Opponent.gameObject.SetActive(false);
        _battleUI.SetActive(false);
        _resultUI.SetActive(false);
        if(IsDebug)
        {
            SetData(userId, opponentId, isMyWin, totalAssetsClimbRange, totalAssetsDeclineRange);
            StartBattle();
        }

        if(_resultData == null)
        {
            Debug.LogError("バトルに使用するデータが設定されていません");
        }
        StartBattle();
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
        var result = await StepGraphDraw(this.myStep, this.opponentStep);

        await UniTask.Delay(3000);
        stepDifferenceLine_Mine.gameObject.SetActive(false);
        stepDifferenceLine_Opponent.gameObject.SetActive(false);
        await _whiteOutImage.DOFade(1f, 1.0f).AsyncWaitForCompletion();

        await UniTask.Delay(1500);
        var resultData = ShowResult(result);
        
    }

    public async UniTask<int> StepGraphDraw(int myStep, int opponentStep)
    {
        _battleUI.SetActive(true);
        _whiteOutImage.DOFade(0f, 1.0f);

        int fewerStep = 0;
        int higherStep = 0;
        Slider higherStepGraph = null;
        LineRenderer stepDifferenceLine = null;
        RectTransform stepDifferenceArrow = null;
        if(myStep < opponentStep)
        {
            fewerStep = myStep;
            higherStep = opponentStep;
            higherStepGraph = _opponentStepGraph;
            stepDifferenceLine = stepDifferenceLine_Opponent;
            stepDifferenceArrow = _stepDifferenceArrow_Mine;
            _stepDifferenceBubble.localRotation = Quaternion.Euler(0f, 0f, -90f);
            _stepDifferenceBubble.GetChild(0).GetComponent<RectTransform>().localRotation = Quaternion.Euler(0f, 0f, 0f);
        }
        else if(myStep > opponentStep)
        {
            fewerStep = opponentStep;
            higherStep = myStep;
            higherStepGraph = _myStepGraph;
            stepDifferenceLine = stepDifferenceLine_Mine;
            stepDifferenceArrow = _stepDifferenceArrow_Opponent;
            _stepDifferenceBubble.localRotation = Quaternion.Euler(0f, 0f, 90f);
            _stepDifferenceBubble.GetChild(0).GetComponent<RectTransform>().localRotation = Quaternion.Euler(0f, 0f, 180f);
        }
        else if(myStep == opponentStep)
        {
            fewerStep = myStep;
            higherStep = opponentStep;
            await DrawMatch();
            return 2;
        }

        float higherStepValue = 1.0f;
        float fewerStepValue = (float)fewerStep / (float)higherStep;

        _myStepGraph.DOValue(fewerStepValue, 3.0f);
        await _opponentStepGraph.DOValue(fewerStepValue, 3.0f).AsyncWaitForCompletion();
        
        await UniTask.Delay(1500);
        await higherStepGraph.DOValue(higherStepValue, 0.5f).AsyncWaitForCompletion();
        DrawStepDifferenceDashLine(stepDifferenceLine, stepDifferenceArrow, fewerStepValue);

        return myStep < opponentStep ? 0 : 1;   
        
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

            _stepDifferenceText.text = $"{Mathf.Abs(this.myStep - this.opponentStep)}歩";
            _stepDifferenceBubble.gameObject.SetActive(true);
        }
        
    }

    private async UniTask DrawMatch()
    {
        float stepValue = 1.0f;

        _myStepGraph.DOValue(stepValue - 0.5f, 3.0f);
        await _opponentStepGraph.DOValue(stepValue - 0.5f, 3.0f).AsyncWaitForCompletion();
        
        await UniTask.Delay(1500);
        _myStepGraph.DOValue(stepValue, 0.5f);
        await _opponentStepGraph.DOValue(stepValue, 0.5f).AsyncWaitForCompletion();

        stepDifferenceLine_Mine.SetPosition(0, stepDifferenceLine_Mine.transform.GetChild(0).position);
        stepDifferenceLine_Mine.SetPosition(1, stepDifferenceLine_Mine.transform.GetChild(1).position);
        stepDifferenceLine_Opponent.SetPosition(0, stepDifferenceLine_Opponent.transform.GetChild(0).position);
        stepDifferenceLine_Opponent.SetPosition(1, stepDifferenceLine_Opponent.transform.GetChild(1).position);

    }

    private ResultData ShowResult(int result)
    {
        int earnings = 0;
        switch(result)
        {
            case 0:
            {
                if(ColorUtility.TryParseHtmlString("#699AE2", out Color color))
                {
                    Debug.Log(color);
                    _resultBG.color = color;
                }
                _resultText.text = "Lose..";
                
                _resultData.isMyWin = false;
                _resultData.totalAssetsClimbRange = (this.opponentStep - this.myStep) * 4;
                _resultData.totalAssetsDeclineRange = (this.myStep - this.opponentStep) * 4;
                earnings = _resultData.totalAssetsDeclineRange;
                _earningsText.text = $"{earnings} 円損失";
                break;
            }
            case 1:
            {
                if(ColorUtility.TryParseHtmlString("#E8764A", out Color color))
                {
                    _resultBG.color = color;
                }
                _resultText.text = "Win!";

                _resultData.totalAssetsClimbRange = (this.myStep - this.opponentStep) * 4;
                _resultData.totalAssetsDeclineRange = (this.opponentStep - this.myStep) * 4;
                _resultData.isMyWin = true;
                earnings = _resultData.totalAssetsClimbRange;
                _earningsText.text = $"{earnings} 円獲得";
                break;
            }
            case 2:
            {
                if(ColorUtility.TryParseHtmlString("#F2E86A", out Color color))
                {
                    _resultBG.color = color;
                }
                _resultText.text = "Draw!";
                _earningsText.text = "損益なし";
                _resultData.totalAssetsClimbRange = 0;
                _resultData.totalAssetsDeclineRange = 0;
                _resultData.isMyWin = false;
                earnings = 0;
                _earningsText.text = $"損益なし";
                break;
            }
            default:
                break;
        }

        _resultUI.SetActive(true);
        _whiteOutImage.DOFade(0f, 1.0f);

        return _resultData;

    }

}
