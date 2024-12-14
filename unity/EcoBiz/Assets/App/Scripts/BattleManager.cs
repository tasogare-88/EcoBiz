using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class BattleManager : MonoBehaviour
{
    [Header("デバッグモード(実行後Startメソッドでバトル開始)")]
    public bool IsDebugMode = false;
    [SerializeField] private RectTransform _myPlayerName; // 自分のプレイヤー名
    [SerializeField] private RectTransform _opponentPlayerName; // 相手のプレイヤー名

    private void Awake() 
    {
        _myPlayerName.gameObject.SetActive(false);
        _opponentPlayerName.gameObject.SetActive(false);
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
        
    }


}
