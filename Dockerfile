# imagem base usada para criar o ambiente
FROM node:lts-alpine

# faz da pasta 'app' o diretório atual de trabalho
WORKDIR /app

# copia os arquivos 'package.json' e 'package-lock.json' (se disponível)
COPY package*.json ./

# instala as dependências do projeto
RUN npm install

# copia arquivos e pastas para o diretório atual de trabalho (pasta 'app')
COPY . .

# expondo a porta do container
EXPOSE 8080

# comando para executar o ambiente de desenvolvimento
CMD [ "npm", "run", "serve" ]
