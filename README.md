# pdi_generator

Projeto criado para a disciplina de Carreira e Certificação usando Dart e Flutter.
O objetivo do projeto é gerar um PDI a partir de uma série de perguntas simples utilizando a API do Gemini.

## Fluxos de interação

```mermaid
flowchart TD
    A[Início do App (MyChat)] --> B[Bot envia 1ª pergunta]
    B --> C[Usuário responde]
    C --> D[Bot envia próxima pergunta]
    D --> C
    C --> E[Fim das perguntas]
    E --> F[Bot: "Gerando seu plano..."]
    F --> G[Gemini gera PDI]
    G --> H[PDI é salvo localmente (Hive)]
    H --> I[Usuário acessa menu "Histórico"]
    I --> J[Visualiza PDIs salvos]
````

## Análise de usabilidade