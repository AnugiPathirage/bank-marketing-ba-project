# bank-marketing-ba-project
# Bank Marketing Campaign Analysis
### Business Analyst Portfolio Project | Anugi Pathirage

---

## Project Overview

This project analyses a real-world bank marketing dataset to answer a key business question:

> **"Which customer segments should the bank target to maximise term deposit subscription rates — and how can the campaign strategy be improved?"**

This is a end-to-end Business Analyst project covering data analysis, insight generation, process review, and a formal business recommendation — structured to reflect real BA deliverables in a Finance/Banking environment.

---

## Business Problem

A Portuguese retail bank ran a series of telemarketing campaigns to sell term deposit products. Despite significant outreach effort, subscription rates remained low. This analysis identifies:

- Which customer profiles are most likely to subscribe
- Which campaign approaches yield the highest conversion
- Where the bank is wasting outreach resources
- Actionable recommendations to improve future campaign ROI

---

## Repository Structure

```
bank-marketing-ba-project/
│
├── data/
│   ├── bank-additional-full.csv        # Raw dataset (UCI ML Repository)
│   └── data_dictionary.md              # Field definitions and business context
│
├── sql/
│   ├── 01_data_exploration.sql         # Initial data profiling queries
│   ├── 02_customer_segmentation.sql    # Customer profile analysis
│   ├── 03_campaign_performance.sql     # Contact strategy analysis
│   └── 04_conversion_analysis.sql      # Subscription rate deep dive
│
├── excel/
│   └── bank_marketing_dashboard.xlsx   # Interactive KPI dashboard
│
├── documentation/
│   ├── business_requirements.md        # BRD — Business Requirements Document
│   ├── business_recommendation.pdf     # Executive summary & recommendations
│   └── process_map.png                 # Current vs improved campaign process
│
└── README.md
```

---

## Dataset

**Source:** [UCI Machine Learning Repository — Bank Marketing Dataset](https://archive.ics.uci.edu/ml/datasets/Bank+Marketing)

| Attribute | Detail |
|-----------|--------|
| Records | 41,188 customer contacts |
| Features | 20 variables (demographic, campaign, economic) |
| Target Variable | `y` — Did the customer subscribe to a term deposit? (yes/no) |
| Time Period | May 2008 – November 2010 |

**Key fields used in this analysis:**

| Field | Description |
|-------|-------------|
| `age` | Customer age |
| `job` | Employment type |
| `education` | Education level |
| `contact` | Contact communication type |
| `campaign` | Number of contacts in this campaign |
| `poutcome` | Outcome of previous campaign |
| `y` | Subscription outcome (target variable) |

---

## Analysis Summary

### Key Questions Answered

1. What is the overall subscription rate and how does it vary by segment?
2. Which age groups and job types convert at the highest rate?
3. Does contact frequency affect conversion — and is there a point of diminishing returns?
4. Which month and day of the week drives the best outcomes?
5. How does previous campaign outcome affect current conversion?
6. What economic conditions correlate with higher subscription rates?

### Headline Findings

- Overall subscription rate: **11.3%** — significant room for improvement
- Customers aged **60+** subscribe at **3x the average rate**
- Contacts beyond **3 calls** show dramatically declining conversion
- **March, September and October** outperform other months significantly
- Customers with a **successful prior campaign outcome** convert at **65%**

*Full findings in `/documentation/business_recommendation.pdf`*

---

## Deliverables

| Deliverable | Description | Location |
|-------------|-------------|----------|
| SQL Analysis | 20+ business queries with commentary | `/sql/` |
| Excel Dashboard | Interactive KPI dashboard with slicers | `/excel/` |
| Business Requirements Document | Formal BRD for a campaign optimisation initiative | `/documentation/` |
| Executive Recommendation | 1-page stakeholder-ready recommendation | `/documentation/` |
| Process Map | As-Is vs To-Be campaign process (BPMN) | `/documentation/` |

---

## Tools Used

| Tool | Purpose |
|------|---------|
| SQLite / DB Browser for SQLite | Data querying and analysis |
| Microsoft Excel | Dashboard and data visualisation |
| draw.io | Process mapping (BPMN notation) |
| GitHub | Version control and portfolio hosting |

---

## BA Skills Demonstrated

- ✅ Business problem framing and scoping
- ✅ Data profiling and exploratory analysis
- ✅ Requirements gathering and BRD writing
- ✅ Stakeholder-ready insight communication
- ✅ Process analysis and improvement mapping
- ✅ MoSCoW prioritisation
- ✅ KPI dashboard design

---

## Contact

**Anugi Pathirage**
BSc Computer Science Graduate | Aspiring Business Analyst | Finance & Banking Focus

[LinkedIn](https://www.linkedin.com/in/anugipathirage)
[GitHub](https://github.com/AnugiPathirage)

---

*This project was independently developed as part of a BA portfolio. The dataset is publicly available via the UCI Machine Learning Repository (Moro et al., 2014).*
