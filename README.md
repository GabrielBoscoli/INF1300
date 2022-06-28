# INF1300

Projeto para a disciplina INF1300 da PUC-Rio.

**Atenção:** o documento contendo imagens ilustrativas pode ser encontrado [aqui](https://docs.google.com/document/d/1mTHIIqMMgB3ql8CTDtI_DQaWAUbZ249aF03MzS2pvKA/edit?usp=sharing).

## Visão geral

O aplicativo desenvolvido possibilita ao usuário o registro dos seus gastos pessoais e oferece uma área de análise de dados que conta com a porcentagem dos gastos e seu valor por categoria (comida, roupa...) em diferentes períodos de tempo. Dessa forma, o app provê auxílio financeiro, ao passo que o usuário passa a ter melhor noção da sua contabilidade.

## Tela inicial

A tela inicial conta com todos os gastos registrados pelo usuário e salvos no banco de dados.

## Criação de novo gasto

Da tela inicial, ao clicar no floating action button, o usuário é direcionado para a tela de criação de um novo gasto. Nela, ele deve inserir a categoria, a data, o valor e uma breve descrição do gasto. Para confirmar a criação, deve clicar no botão confirmar apenas depois de preencher todos os itens. A categoria é selecionada através de um dropdown e cada uma possui uma cor correspondente que é refletida no Color Indicator ao lado. A data, por sua vez, é selecionada através de um Date Picker. Atualmente, não é permitida a inserção de gastos futuros, apenas do dia atual para trás. Por fim, o campo valor aceita apenas números e o de descrição qualquer caractere.

## Criação de nova categoria

O usuário deve ser capaz de criar a categoria que julgar necessária. Para isso, basta clicar em "Nova Categoria +" no formulário do gasto e ele será redirecionado para a tela de criação de uma nova categoria. Uma categoria consiste de um nome, que deve ser único, e uma cor, que pode repetir. O campo nome aceita qualquer caractere. A cor é selecionada através de um Block Picker. Somente depois de preencher os dois campos o usuário poderá realizar a criação da categoria ao clicar no botão Confirmar.

## Edição de um gasto

Caso o usuário tenha cometido algum erro ao registrar um gasto, ele poderá corrigi-lo ao identificá-lo na lista de gastos e clicar no ícone de edição, representado por um lápis. Depois de realizado o clique, o usuário é redirecionado para a tela de edição do gasto. Ela é semelhante à de novo gasto, porém já preenchida com os dados do gasto a ser editado e com a adição de um ícone de lixeira no App Bar, que permite a exclusão dele. Após editar o campo desejado e clicar no botão Confirmar, o gasto é atualizado no banco de dados e também na lista inicial.

## Remoção de um gasto

A partir da tela de edição de gasto, o usuário pode optar por excluí-lo ao clicar no ícone de lixeira que se encontra no canto superior direito do aplicativo. Uma caixa de diálogo aparecerá perguntando se o usuário realmente deseja efetuar essa ação, visto que o gasto será removido do banco de dados e não há como recuperá-lo. Caso clique em Yes, o gasto é deletado e o usuário volta para a lista inicial, que não contará mais com ele. Caso clique em No, o usuário permanece na tela de edição do gasto.

## Análise dos dados

A área de análise dos dados pode ser acessada através do ícone de gráfico no canto superior direito da tela inicial, a lista dos gastos. Essa área conta com dois campos, a data inicial e a data final. Apenas os gastos que se encontram em um período de tempo que compreende ambas as datas serão incluídos na análise. Primeiramente, a data inicial é preenchida com o primeiro dia do mês corrente, enquanto a data final é preenchida com o dia atual. Ambas as datas podem ser alteradas de acordo com a vontade do usuário. Uma vez alteradas, os gastos usados para base de cálculo serão atualizados e, consequentemente, serão apresentadas novas informações. Cada item exibido mostra valores referentes a uma categoria, o total de dinheiro gasto com ela e a porcentagem em relação ao total geral gasto no período. Dessa forma, o usuário pode ter uma noção melhor do seu consumo e comparar através do tempo.

## Conversão do real

Ao pressionar um item da análise de dados por um breve momento, o usuário é redirecionado para uma página que exibe o valor total em diferentes unidades monetárias. Nesse exemplo, o valor R$ 49.99 é convertido para dólar, euro, libras e outras moedas.

## Características/Features

- Widgets ListTile ou Card (contendo um ícone ou imagem, e título, subtítulo)

Os itens da lista de gastos são Cards cujo child são ListTiles. Cada um deles possui dois ícones, um título composto pela categoria e o valor do gasto e o subtítulo que é a descrição dele.

- Criar um layout mais complexo usando widgets Row/Column aninhados, GridView ou stack

A imagem conta com o widget SeletorCategoria, cujo layout é composto de uma Column em que o children é uma Row com o Dropdown e o Color Indicator e, fora da Row, o Text Button.

- Widget Container: para alterar os espaçamentos de borda de um widget filho

O Container foi empregado nos itens da lista que contém os valores em diferentes moedas. Possibilitou a edição do padding e margin dos elementos. Nesse caso de uso, serviu como uma alternativa ao Card ou ListTile.

- Navegação entre pelo menos 3 telas usando named routes

A navegação para a tela de criação de um novo gasto, criação de uma nova categoria e para a área de análise de dados é feita através de named routes.

- Uso de Theme e TextTheme: para customizar o look&feel do seu app

O Theme usado pelo app é o Dark. Ele faz com que todas as telas compartilhem de uma temática mais escura, com tons de cinza, branco e um pouco de azul. O TextTheme também foi usado em alguns momentos para que o texto também possua uma identidade. Os elementos destacados na imagem usam o mesmo style obtido pelo TextTheme.

- Usar HTTP para acesso remoto de alguma API para buscar uma coleção de dados ou imagens de um servidor backend e apresentação em uma ListView

Os dados dos itens da ListView de conversão de valores são obtidos através de um http request para acesso à api financeira da hgbrasil, que fornece a cotação de várias moedas diferentes ao redor do mundo.

- Uso do GestureDetection para redefinir uma gesture diferente sobre algum widget “acionável”, como por exemplo um “onLongPress”, em vez de um “onTap”

Foi usado GestureDetection para fazer com que um toque mais longo em um item da lista de análise de dados abra a tela de conversão do real para outras moedas.

- Usar o image_picker

Essa feature foi a única que não foi implementada.
