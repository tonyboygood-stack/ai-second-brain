# 個人醫學知識庫

為中西醫臨床醫師設計的 AI 第二大腦。  
採用 **LLM Wiki 模式**處理知識整理，結合 **Zettelkasten 精神**保留臨床洞見。

---

## 架構總覽

```
00-inbox/        ← 零摩擦輸入（下診後、讀書中隨手記）
10-library/      ← 原始文本（AI 查詢用）
20-cards/        ← 知識卡片（AI 從 library 整理並維護）
30-cases/        ← 臨床案例庫
40-insights/     ← 你的臨床洞見
```

## 核心工作流程

**下診後（3 分鐘）：**
1. 在 `00-inbox/clinic/` 寫下臨床觀察與問題
2. 告訴 Claude：「處理 inbox」
3. Claude 自動：建立/更新案例、萃取問題、建立知識卡、補充 library 內容

**讀書/看影片（隨時）：**
1. 在 `00-inbox/reading/` 記下重點段落與你的想法
2. 全文存入 `10-library/`（有的話）
3. 告訴 Claude：「整理 library」或「處理 inbox」

**知識長大的路徑：**
```
inbox 一句話
  → 20-cards/ 知識卡（AI 補充 library 內容）
    → 你填入「你的理解」
      → 40-insights/ 臨床洞見（你的，AI 建議觸發）
        → 連結回 30-cases/ 相關案例
```

## 快速指令

在 Claude Code 中直接說：

| 你說的話 | Claude 做什麼 |
|---------|--------------|
| 「處理 inbox」 | 掃描 inbox，建案例、建 cards、找連結 |
| 「整理 library」 | 從新加入的文本萃取並更新 cards |
| 「[病人] 最新狀況」 | 顯示案例摘要與相關知識 |
| 「找關於 [主題] 的資料」 | 搜尋所有 cards、cases、insights |
| 「建議我寫 insight」 | 掃描近期記錄，提出洞見建議 |

## 設計原則

- **你的思考 > AI 的整理**：Cards 是 AI 的工作，Insights 是你的工作
- **摩擦越低越好**：一句話的 inbox 記錄比沒記更有價值
- **問題驅動**：遇到臨床問題才加入相關 library 文本，不需預先整理
- **增量成長**：系統隨你的問題自然長大

## 詳細操作規則

見 [CLAUDE.md](./CLAUDE.md)
