# HTML 研报输出模板

## 一、文件命名

`<topic>-<YYYYMMDD>.html`（如 `market-analysis-20261103.html`）

## 二、研报结构（固定顺序）

```
1. <header> 标题 + 副标题 + 日期徽章
2. <div class="tldr"> 核心结论卡片（TL;DR）
3. <div class="kpi-row"> KPI 数字卡片（3 大指数 + 成交额）
4. <section> 市场状态：指数走势 + 涨跌表 + 广度图 + 量能图
5. <section> 风格与板块：行业涨跌图 + 轮动表 + 主线识别表
6. <section> 资金面：主力资金图 + 资金维度表
7. <section> 宏观传导：传导链 + 事件日历
8. <section> 综合判断：市场档位 verdict + 估值表
9. <section> 观察清单
10. <section> 数据来源汇总
11. <div class="disclaimer"> 免责声明
12. <footer> 生成时间
```

## 三、CSS 变量与配色

```css
:root {
  --bg: #f7f5f0;        /* 浅底 */
  --card: #ffffff;       /* 卡片 */
  --ink: #1a1a2e;        /* 深字 */
  --accent: #c0392b;     /* 红色（涨） */
  --green: #27ae60;      /* 绿色（跌） */
  --gold: #b8860b;       /* 强调 */
}
```

**A 股约定**：红涨绿跌。`.up { color: #c0392b; }` `.down { color: #27ae60; }`

## 四、ECharts 骨架（套用填 data，勿从零手敲）

### 4.1 柱状图（指数涨跌幅对比）

```javascript
echarts.init(document.getElementById('chart1')).setOption({
  tooltip: { trigger: 'axis' },
  legend: { data: ['上证指数', '深证成指', '创业板指'] },
  xAxis: { type: 'category', data: ['10-27', '10-28', '10-29', '10-30', '11-02', '11-03'] },
  yAxis: [{ type: 'value', name: '涨跌幅(%)', axisLabel: { formatter: '{value}%' } }],
  series: [
    { name: '上证指数', type: 'bar', data: [-1.33, 0.91, -0.82, -1.44, 1.08, -0.92], itemStyle: { color: '#c0392b' } },
    { name: '深证成指', type: 'bar', data: [-2.50, 2.02, -2.92, -2.73, 1.63, -1.02], itemStyle: { color: '#e67e22' } },
    { name: '创业板指', type: 'bar', data: [-3.41, 3.40, -4.45, -4.13, 1.87, -2.42], itemStyle: { color: '#2980b9' } }
  ],
  grid: { left: 50, right: 20, top: 40, bottom: 30 }
});
```

### 4.2 饼图（涨跌分布）

```javascript
echarts.init(document.getElementById('chart2')).setOption({
  tooltip: { trigger: 'item', formatter: '{b}: {c}家 ({d}%)' },
  series: [{
    type: 'pie',
    radius: ['35%', '65%'],
    data: [
      { name: '涨停', value: 52, itemStyle: { color: '#c0392b' } },
      { name: '上涨', value: 1941, itemStyle: { color: '#f5c842' } },
      { name: '平盘', value: 172, itemStyle: { color: '#bdc3c7' } },
      { name: '下跌', value: 3399, itemStyle: { color: '#27ae60' } },
      { name: '跌停', value: 14, itemStyle: { color: '#0b3d20' } }
    ],
    label: { formatter: '{b}', fontSize: 10 }
  }]
});
```

### 4.3 折线图（成交额趋势）

```javascript
echarts.init(document.getElementById('chart3')).setOption({
  tooltip: { trigger: 'axis' },
  xAxis: { type: 'category', data: ['10-27', '10-28', '10-29', '10-30', '11-02', '11-03'] },
  yAxis: { type: 'value', name: '成交额(万亿元)' },
  series: [{
    name: '两市成交额', type: 'line',
    data: [1.46, 1.63, 1.56, 1.67, 1.80, 1.57],
    smooth: true, symbolSize: 8,
    lineStyle: { width: 3, color: '#2980b9' },
    itemStyle: { color: '#2980b9' },
    areaStyle: { color: 'rgba(41,128,185,0.12)' },
    markLine: { silent: true, data: [{ yAxis: 2.0, lineStyle: { color: '#c0392b', type: 'dashed' } }] }
  }]
});
```

### 4.4 横向条形图（行业涨跌 / 资金流向）

```javascript
echarts.init(document.getElementById('chart4')).setOption({
  tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
  xAxis: { type: 'value', name: '涨跌幅(%)' },
  yAxis: { type: 'category', data: ['通信', '电子', '计算机', '银行', '石油石化'] },
  series: [{
    type: 'bar',
    data: [
      { value: -14.77, itemStyle: { color: '#27ae60' } },
      { value: -13.82, itemStyle: { color: '#27ae60' } },
      { value: -10.85, itemStyle: { color: '#27ae60' } },
      { value: 4.97, itemStyle: { color: '#c0392b' } },
      { value: 3.50, itemStyle: { color: '#c0392b' } }
    ],
    label: { show: true, position: 'right', formatter: '{c}%', fontSize: 11 }
  }]
});
```

## 五、JS 语法自检（必须执行）

```bash
# 提取 HTML 中的 <script> 块并校验
python3 -c "
import re
html = open('output.html', encoding='utf-8').read()
scripts = re.findall(r'<script>(.*?)</script>', html, re.DOTALL)
for i, s in enumerate(scripts):
    open(f'_check_{i}.js', 'w', encoding='utf-8').write(s)
"
node --check _check_0.js
# 通过 → 交付；报错 → 修到通过再交付
```

或运行 `scripts/check_js_syntax.sh <html文件路径>`。

## 六、免责声明（固定文案，禁止改写/缩减/省略）

> **免责声明**：以上内容基于公开数据和量化分析，仅供参考，不构成投资建议。市场有风险，投资需谨慎。任何投资决策应结合个人风险承受能力、资金状况和投资目标独立判断，必要时咨询持牌专业机构。过往表现不预示未来收益。
