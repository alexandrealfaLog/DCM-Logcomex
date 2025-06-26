# Processo de submissão de alterações no banco de dados

1. Crie uma nova branch:
   ```bash
   git checkout -b feature/2025-06-26-add-trial-plan
2. Crie um novo arquivo em migrations/ baseado no template.
3. Preencha os metadados no cabeçalho SQL.
4. Submeta um Pull Request com:
- Título descritivo
- Corpo explicando o impacto
- Marque reviewers: @dba @techlead @arquiteto

5. Após aprovado, o script será executado manualmente ou via pipeline.