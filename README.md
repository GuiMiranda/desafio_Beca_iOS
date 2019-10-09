# Desafio BECA[iOS] Everis!!!

Seja bem-vindo!

#### LEIA AS INSTRUÇÕES POR COMPLETO ANTES DE COMEÇAR

O Desafio consiste no desenvolvimento de um app bem simples que consome a [API](https://developers.themoviedb.org/3/getting-started/introduction) do [TheMovieDB](https://www.themoviedb.org/?language=en).

Você não precisa se preocupar tanto com o design. Esse não é o objetivo do desafio. Tenha em mente que seu código e app serão avaliados em todos os aspectos, então cada detalhe conta. Faça disso uma oportunidade pra mostrar todo o seu conhecimento.

O único pré requisito é que o app seja feito em Swift, mas atente-se aos seguintes pontos:
* Prefere-se a utilização de ferramentas nativas;
* Caso opte por usar libs externas, prefira CocoaPods;
* É preferível que a interface seja feita utilizando Xibs;

## Features
### Obrigatórias:
* Tab bar com dois ítens: Filmes e Favoritos, sendo a principal a tab de Filmes;
* A tela de Filmes deverá conter:
	* Uma lista dos [filmes populares](https://developers.themoviedb.org/3/movies/get-popular-movies) da API;
	* Cada elemento da lista deve conter o poster, o nome e o ano que o filme foi produzido;
	* Ao clicar em um ítem, deve ser apresentada a tela de detalhes (tela descrita abaixo);
	* Search bar para pesquisar filmes por nome;

* A tela de favoritos deverá conter:
	* Search bar para pesquisar favoritos por nome e ano;
	* Ao clicar em um ítem, deve ser apresentada a tela de detalhes (tela descrita abaixo);
* A tela de detalhes deve apresentar os seguintes dados do filme: *(não necessariamente nessa ordem)*
	* Poster;
	* Botão para favoritar/desfavoritar;
	* Título;
	* Sinopse;
	* Nota do filme;
	* E os gêneros por extenso.
* É necessário fazer tratamento de erros e dos fluxos de exceção, como busca vazia, carregando e outros erros que possam ocorrer.

### Opcionais:
#### Não necessário, porém contam pontos.
* Desenvolver testes unitários e/ou funcionais;
* botão de favoritar/desfavoritar nos item das listas;
* Pull-to-refresh nas listas;
* Paginação na tela principal ou infinity scroll;
* Opções de filtro e ordenação nas listas;

### Boa sorte.
