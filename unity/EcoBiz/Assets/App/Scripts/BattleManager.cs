using UnityEngine;
public class BattleManager : MonoBehaviour
{
    public void SendBattleResultToFlutter(string winnerId, string loserId, int stepsDifference, int amountChanged)
    {
        var battleResult = new
        {
            winnerId = winnerId,
            loserId = loserId,
            stepsDifference = stepsDifference,
            amountChanged = amountChanged
        };

        var jsonData = JsonUtility.ToJson(battleResult);
        UnityMessageManager.Instance.SendMessageToFlutter(jsonData);

        Debug.Log($"Flutterに勝敗データを送信しました: {jsonData}");
    }
}
