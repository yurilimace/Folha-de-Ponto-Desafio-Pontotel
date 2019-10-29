# Folha-de-Ponto-Desafio-Pontotel
Projeto desenvolvido para a participação do processo seletivo da empresa Pontotel, que consiste na criação de um frontend para consumir uma API e exibe a folha de pontos dos usuários

## Depêndencias Utilizadas
No desenvolvimento da solução foram usadas as seguintes depêndencias
- [VueJs](https://vuejs.org/)
- [Axios](https://github.com/axios/axios)
- [MomentJS](https://momentjs.com/docs/)
- [Bootstrap](https://getbootstrap.com/)
- [Font-Awsome](https://fontawesome.com/)

## Como utilizar

Tem duas maneiras de rodar esta aplicação:

---
1. Com o NodeJS instalado no seu PC

Necessário baixar as dependências do projeto através do comando:

```bash
$ npm install
```

Executar em ambiente de desenvolvimento:

```bash
$ npm run serve
```

---
2. Docker

Para rodar a aplicação usado Docker, basta você buildar a imagem docker usando o `Dockerfile` deste repositório:
``` 
docker build -t desafio-pontotel .
```

Após o build da imagem docker, rode o conteiner usando o seguinte comando:
``` 
docker run -p 8080:8080 --name "desafio" desafio-pontotel 
```
Para acessar a aplicação, vá no browser e acesse:
``` 
http://localhost:8080/  
```

## Autor 
---
*  José Yuri Lima Lira  - [yurilimace](https://github.com/yurilimace)
