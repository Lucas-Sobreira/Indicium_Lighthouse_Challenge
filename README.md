Best Practices of DBT-Core.
<a href="https://docs.getdbt.com/best-practices/how-we-structure/2-staging">documentação</a>

Baseado em um desafio, resolvi realizar esse projeto e desenvolver em DBT-Core. 

### Dockerfile
O último comando do Dockerfile, mantém o container do DBT-Core ativo, podendo utilizar o terminal "Exec" através do Docker Desktop. Ou acessar o bash do container utilizando o comando abaixo.
``` Dockerfile: 
CMD tail -f /dev/null
```

Para entrar dentro do bash do Container: 
``` bash: 
docker exec -it <container_id> bash 
```

1) O primeiro desafio, foi a construção do Docker-Compose com as ferramentas Postgres e Pgadmin. Já com a inicialização do projeto, utilizando o arquivo .SQL armazenado na pasta northwind_data; 

``` bash: 
dbt debug
```

2) Depois disso, testado, adicionei a imagem do DBT-Core e fiz as configurações para que conversasse com o Postgres local. Realizando o teste de conexão, criando a tabela "order_details", utilizando o arquivo .CSV contido na pasta Seed, através do arquivo Dockerfile.yml; 

``` bash: 
dbt seed
```

3) Como quis dividir em três schemas diferentes, para fins de organização e criar um DW com camadas medalhão. Tive que alterar o código .sql para que o nome do Schema padrão "public" fosse renomeado para "raw" e assim conseguir finalizar a primeira camada. Tendo criado a maioria das tabelas utilizando o arquivo .sql e complementando as tabelas com uma a mais vindo do arquivo .csv;

``` sql: 
ALTER SCHEMA public RENAME TO raw
```

4) Foi adicionado ao Dockerfile um comando para rodar o "dbt seed" e manter o container UP. 
``` Dockerfile: 
CMD dbt seed && tail -f /dev/null
```

5) Criando as Materialized Views utilizando a pasta "models/staging". 

6) Download de Packages para auxiliar nos testes unitários ou outros processos. Basicamente criar um arquivo "packages.yml" especificando quais pacotes gostaria de instalar e rodar um comando DBT.
<a href="https://docs.getdbt.com/docs/build/packages">link_referencia</a>
```bash: 
dbt deps
```

## Rodando a aplicação 
1) Fazer clone do repositorio; 
2) No seu bash executar os comandos: 
``` bash: 
docker-compose build
docker-compose up -d
```
3) Dentro do terminal do DBT-Core, executar os comandos:
- Verificar se está tudo certo com o clone do repositorio:
``` bash: 
dbt debug
```

- Rodar os comandos para criação de tabelas e views no Postgres
``` bash: 
dbt seed
dbt run
```
4) Caso queira testar alguma coisa: 
``` bash: 
dbt test
```