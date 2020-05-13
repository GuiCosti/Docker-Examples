# Cria a sua imagem a partir de uma outra imagem preexistente (Nesse caso uma imagem node.js). 
# Podemos especificar a versão também, utilizando node:latest ou node:3.2.0 (seria a versão 3.2.0s).
# Se você não colocar nada, ele vai assumir que é a última versão
FROM node:latest

# Especifica que está cuidando dessa imagem, ou seja, o autor da imagem 
# Antigo MAINTAINER
LABEL Guilherme Costi

# Cria variváveis de ambiente dentro do container
ENV NODE_ENV=production
ENV PORT=3000

# Copia o que você indicar para dentro da imagem (primeiro vem o diretório do seu computador, depois vem para onde você quer enviar dentro da imagem).
# Ponto "." copia tudo
COPY . /var/www

# Muda o diretório do container para a pasta específica
WORKDIR /var/www

# Executa o comando dentro do container
RUN npm install

# Qual porta o container vai utilizar (expõe a porta)
# EXPOSE $PORT
EXPOSE 3000

# Executa o comando quando o container iniciar
# Similar ao RUN
# Ou ENTRYPOINT npm start , é equivalente
ENTRYPOINT [ "npm", "start" ]