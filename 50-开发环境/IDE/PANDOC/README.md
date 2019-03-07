# 命令
```
pandoc --filter mermaid-filter --filter pandoc-plantuml-filter --pdf-engine=xelatex -V CJKmainfont='华文仿宋' --highlight-style zenburn -o test.pdf 业务流程-采购.md
```
- mermaid流程图导出不太清晰，需要优化

