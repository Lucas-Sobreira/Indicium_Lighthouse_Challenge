# syntax=docker/dockerfile:1
FROM python:3.12

WORKDIR /usr/app/northwind

# Instalar dependências 
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

WORKDIR /user/app/northwind

EXPOSE 8081

# Comando para manter o container rodando
CMD tail -f /dev/null

# Comando para rodar o Seed
CMD ["dbt", "seed"]

# Comando para rodar o Seed
CMD ["dbt", "run"]