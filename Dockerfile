# Fase 1: Build
FROM node:20 AS build

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o arquivo package.json e package-lock.json para o diretório de trabalho
COPY package*.json ./

#RUN npm install --silent && npm install react-scripts@5.0.1 -g --silent

# Instale as dependências do projeto
RUN npm install

# Copie o restante do código da aplicação para o diretório de trabalho
COPY . .

# Construa o projeto React
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]

# # Fase 2: Servir a aplicação com Nginx
# FROM nginx:alpine

# # Set working directory to nginx resources directory
# WORKDIR /usr/share/nginx/html
# # Remove default nginx static resources
# RUN rm /etc/nginx/conf.d/default.conf

# # Copie os arquivos estáticos do build anterior para o diretório padrão do Nginx
# COPY --from=build /app/build /usr/share/nginx/html

# # Copie o arquivo de configuração do Nginx, se necessário
# COPY nginx.conf /etc/nginx/nginx.conf

# # Exponha a porta em que o Nginx estará servindo a aplicação (geralmente 80)
# EXPOSE 80

# # Comando padrão para iniciar o Nginx
# CMD ["nginx", "-g", "daemon off;"]