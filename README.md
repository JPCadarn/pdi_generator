# pdi_generator

Projeto criado para a disciplina de Carreira e Certificação usando Dart e Flutter.
O objetivo do projeto é gerar um PDI a partir de uma série de perguntas simples utilizando a API do Gemini.

## Fluxos de interação

```mermaid
flowchart TD
    A[Início do App] --> B[Bot envia 1ª pergunta]
    B --> C[Usuário responde]
    C --> D[Bot envia próxima pergunta]
    D --> C
    C --> E[Fim das perguntas]
    E --> F[Bot: Gerando seu plano...]
    F --> G[Gemini gera PDI]
    G --> H[PDI é salvo localmente Hive]
    H --> I[Usuário acessa menu Histórico]
    I --> J[Visualiza PDIs salvos]
````

## Análise de usabilidade
# Análise de Usabilidade

## Projeto: pdi_generator

### 1. Navegação e Fluxo de Usuário

- A navegação é linear, baseada em páginas sequenciais (ex.: perguntas do PDI).
- É recomendável incluir uma indicação clara do progresso, como uma barra ou stepper, para que o usuário saiba quantas perguntas faltam.
- Botões de avanço e retrocesso devem estar bem posicionados e possuir labels claras para evitar confusão.

### 2. Clareza e Feedback

- Os textos das perguntas são diretos, mas a interface deve oferecer feedback imediato após a interação do usuário (ex.: seleção confirmada, botão habilitado/desabilitado).
- É importante apresentar mensagens de erro ou alertas para inputs obrigatórios ou inválidos.
- Indicadores visuais, como spinners ou barras de progresso, devem estar presentes em operações de carregamento.

### 3. Interação e Controle

- Elementos interativos (botões, campos de resposta) devem ter tamanho adequado para fácil toque, especialmente em dispositivos móveis.
- O usuário deve poder revisar e editar respostas antes da submissão final.
- Caso seja possível, permita que o usuário navegue para perguntas anteriores para alterar respostas.

### 4. Acessibilidade

- Garantir contraste suficiente entre texto e fundo para facilitar a leitura.
- Elementos interativos devem ser acessíveis via teclado e compatíveis com leitores de tela.
- Uso correto de labels e roles para suporte a tecnologias assistivas.

### 5. Consistência Visual

- Manter padrão visual para botões, fontes e cores em toda a aplicação.
- Espaçamentos e alinhamentos coerentes para evitar poluição visual.
- Ícones podem ser usados para complementar textos e facilitar compreensão rápida.

### 6. Potenciais Melhorias

- Adicionar indicação visual de progresso do usuário durante o preenchimento do PDI.
- Implementar validações em cada etapa para evitar respostas incompletas.
- Oferecer opção de salvar progresso e retomar posteriormente.
- Garantir mensagens claras e visíveis para erros e confirmações.
- Melhorar responsividade para diferentes tamanhos e orientações de tela.
- Para fluxos longos, dividir em blocos menores para evitar fadiga do usuário.

---