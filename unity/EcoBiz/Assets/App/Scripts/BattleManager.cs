using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using Cysharp.Threading.Tasks;

public class BattleManager : MonoBehaviour
{
    [Header("デバッグモード(実行後Startメソッドでバトル開始)")]
    public bool IsDebug = false;

    private class BattleData
    {
        public string userName; // バトルを仕掛けたユーザーの名前
        public string opponentName; // 対戦相手の名前
        public int mySteps; // バトルを仕掛けたユーザーの歩数
        public int opponentSteps; // 対戦相手の歩数
        public bool isWinner;  // 対戦相手の歩数
        public bool isDraw; // バトルを仕掛けたユーザーが勝ったか否か
        public int assetChange; // 資産の変動額（勝者が得る/敗者が失う金額）
    }
    private BattleData _battleData = null;

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

    /// <summary>
    /// バトルデータをセットする
    /// </summary>
    /// <param name="jsonBattleData"></param> <summary>
    /// 
    /// </summary>
    /// <param name="jsonBattleData"></param>
    public void SetBattleData(string jsonBattleData)
    {
        var battleData = JsonUtility.FromJson<BattleData>(jsonBattleData);
        _battleData = new BattleData();
        _battleData.userName = battleData.userName;
        _battleData.opponentName = battleData.opponentName;
        _battleData.mySteps = battleData.mySteps;
        _battleData.opponentSteps = battleData.opponentSteps;
        _battleData.isWinner = battleData.isWinner;
        _battleData.assetChange = battleData.assetChange;
        
        StartBattle();
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
            SetBattleData("{\"userName\":\"userA\",\"opponentName\":\"userB\",\"mySteps\":100,\"opponentSteps\":150,\"isWinner\":false,\"isDraw\":false,\"assetChange\":400}");
        }
    }

    public async void StartBattle()
    {
        // 中央の斜め白色のラインをフェードイン
        _vsLineImage.DOFade(1f, 0.5f).WaitForCompletion();
        await UniTask.Delay(500);

        // VSエリアのオレンジ部分と青部分をフェードイン
        _vsBGBlue.DOAnchorPos3DX(0, 1.0f).SetEase(Ease.OutQuart);
        await _vsBGOrange.DOAnchorPos3DX(0, 1.0f).SetEase(Ease.OutQuart)
        .OnComplete(() => {
            _myPlayerName.GetComponent<Text>().text = _battleData.userName;
            _myPlayerName.gameObject.SetActive(true);
            _opponentPlayerName.GetComponent<Text>().text = _battleData.opponentName;
            _opponentPlayerName.gameObject.SetActive(true);
            _vsText.gameObject.SetActive(true);
            _vsText.DOScale(Vector3.one, 0.8f).SetEase(Ease.OutBack);
        })
        .AsyncWaitForCompletion();
        await UniTask.Delay(1500);
        // ホワイトアウト
        await _whiteOutImage.DOFade(1f, 1.0f).AsyncWaitForCompletion();
        await UniTask.Delay(1500);
        // 歩数の比較グラフを表示
        var result = await StepGraphDraw(_battleData.isWinner, _battleData.isDraw, _battleData.mySteps, _battleData.opponentSteps);
        await UniTask.Delay(3000);
        // ホワイトアウト
        stepDifferenceLine_Mine.gameObject.SetActive(false);
        stepDifferenceLine_Opponent.gameObject.SetActive(false);
        await _whiteOutImage.DOFade(1f, 1.0f).AsyncWaitForCompletion();
        await UniTask.Delay(1500);
        // リザルト表示
        ShowResult(result);
        
    }

    public async UniTask<int> StepGraphDraw(bool isWinner, bool isDraw, int myStep, int opponentStep)
    {
        _battleUI.SetActive(true);
        _whiteOutImage.DOFade(0f, 1.0f);

        int fewerStep = 0;
        int higherStep = 0;
        Slider higherStepGraph = null;
        LineRenderer stepDifferenceLine = null;
        RectTransform stepDifferenceArrow = null;

        if(isDraw)
        {
            fewerStep = myStep;
            higherStep = opponentStep;
            await DrawMatch();
            return 2;
        }
        else if(!isWinner)
        {
            fewerStep = myStep;
            higherStep = opponentStep;
            higherStepGraph = _opponentStepGraph;
            stepDifferenceLine = stepDifferenceLine_Opponent;
            stepDifferenceArrow = _stepDifferenceArrow_Mine;
            _stepDifferenceBubble.localRotation = Quaternion.Euler(0f, 0f, -90f);
            _stepDifferenceBubble.GetChild(0).GetComponent<RectTransform>().localRotation = Quaternion.Euler(0f, 0f, 0f);
        }
        else if(isWinner)
        {
            fewerStep = opponentStep;
            higherStep = myStep;
            higherStepGraph = _myStepGraph;
            stepDifferenceLine = stepDifferenceLine_Mine;
            stepDifferenceArrow = _stepDifferenceArrow_Opponent;
            _stepDifferenceBubble.localRotation = Quaternion.Euler(0f, 0f, 90f);
            _stepDifferenceBubble.GetChild(0).GetComponent<RectTransform>().localRotation = Quaternion.Euler(0f, 0f, 180f);
        }

        float higherStepValue = 1.0f;
        float fewerStepValue = (float)fewerStep / (float)higherStep;

        _myStepGraph.DOValue(fewerStepValue, 3.0f);
        await _opponentStepGraph.DOValue(fewerStepValue, 3.0f).AsyncWaitForCompletion();
        await UniTask.Delay(1500);
        
        await higherStepGraph.DOValue(higherStepValue, 0.5f).AsyncWaitForCompletion();
        // ステップ差分の矢印を表示
        DrawStepDifferenceDashLine(stepDifferenceLine, stepDifferenceArrow, fewerStepValue);

        return isWinner ? 1 : 0;   
        
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

            _stepDifferenceText.text = $"{Mathf.Abs(_battleData.mySteps - _battleData.opponentSteps)}歩";
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

    private void ShowResult(int result)
    {
        switch(result)
        {
            case 0:
            {
                if(ColorUtility.TryParseHtmlString("#699AE2", out Color color))
                {
                    _resultBG.color = color;
                }
                _resultText.text = "Lose..";
                _earningsText.text = $"{_battleData.assetChange} 円損失";
                break;
            }
            case 1:
            {
                if(ColorUtility.TryParseHtmlString("#E8764A", out Color color))
                {
                    _resultBG.color = color;
                }
                _resultText.text = "Win!";
                _earningsText.text = $"{_battleData.assetChange} 円獲得";
                break;
            }
            case 2:
            {
                if(ColorUtility.TryParseHtmlString("#F2E86A", out Color color))
                {
                    _resultBG.color = color;
                }
                _resultText.text = "Draw!";
                _earningsText.text = $"損益なし";
                break;
            }
            default:
                break;
        }

        _resultUI.SetActive(true);
        _whiteOutImage.DOFade(0f, 1.0f);

    }

}
