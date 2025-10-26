# 🎬 CineHub — Catálogo de Filmes

[![Rails](https://img.shields.io/badge/Rails-7.1.5.2-red)](https://rubyonrails.org/) 
[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-red)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)](https://www.postgresql.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind-3.3-blue?logo=tailwind-css)](https://tailwindcss.com/)
[![Render](https://img.shields.io/badge/Deploy-Render-blueviolet)](https://render.com/)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-Image%20Storage-blue)](https://cloudinary.com/)
[![Coverage](https://img.shields.io/badge/coverage-99%25-brightgreen)](#)
[![Tests](https://img.shields.io/badge/tests-78%20passed-blue)](#)

**CineHub** é uma aplicação web desenvolvida em Ruby on Rails que funciona como um catálogo completo de filmes. Permite que usuários se cadastrem, façam login e gerenciem seus filmes com facilidade, incluindo criação, edição e exclusão de registros. Além disso, qualquer usuário pode visualizar os detalhes de um filme — como título, sinopse, ano de lançamento, duração, diretor e categorias — e interagir por meio de comentários, sejam eles anônimos ou vinculados ao perfil do usuário.

O projeto também inclui funcionalidades avançadas, como importação em massa de filmes via CSV processada em background com Sidekiq, upload e gerenciamento de posters de filmes e imagens de perfil utilizando Active Storage integrado ao Cloudinary, garantindo armazenamento seguro na nuvem e otimização das imagens para performance e responsividade, além de funcionalidades de busca e filtros inteligentes por título, diretor, ano e categoria, e suporte a internacionalização (PT/EN). 

O projeto utiliza Tailwind CSS para estilização, garantindo uma interface moderna, responsiva e fácil de manter, sem necessidade de CSS customizado pesado. Com atenção às boas práticas do Rails Way, o CineHub combina organização de código, experiência do usuário, e performance de maneira eficiente.

## 🔗 Demo
- Deploy público utilizando Render: [CineHub](https://cinehub-uv4d.onrender.com/)
- Demonstração da aplicação:
<p float="center">
  <img src="https://github.com/user-attachments/assets/674d8f83-eba4-4ad0-877a-ad5237e58944" width="600" />
  <img src="https://github.com/user-attachments/assets/d0664575-32a5-4d5e-9aa5-0a9651c2b7fe" width="220" />
</p>
<img width="800" alt="image" src="https://github.com/user-attachments/assets/6ec9ecaf-eccf-4b4c-bd21-9b2b8af6e44c" />
<img width="800" alt="image" src="https://github.com/user-attachments/assets/1bf1e07e-a0bb-423d-b95b-24ad52feecfd" />

## 🚀 Tecnologias
- **Backend:** Ruby on Rails  
- **Banco de Dados:** PostgreSQL  
- **Frontend:** HTML, CSS, JavaScript e estilização com Tailwind CSS
- **Deploy:** Render
- **Uploads de imagem:** Active Storage
- **Armazenamento de imagens em nuvem:** Cloudinary  
- **Processamento em background:** Sidekiq  
- **Internacionalização:** I18n (PT/EN)  

## 📋 Funcionalidades

### Área pública
- Listagem de filmes (mais recentes primeiro)
- Busca e filtros de filmes por título, diretor, ano e categoria
- Visualização de detalhes: título, sinopse, ano, duração, diretor, categoria e tags
- Comentários anônimos
- Cadastro de usuário e recuperação de senha  

### Área autenticada
- Cadastro, edição e exclusão de filmes cadastrados
- Upload de arquivos CSV para importação de filmes
- Notificação por e-mail após a importação  
- Gerenciamento de importações de filmes
- Comentários vinculados automaticamente ao usuário  
- Edição de perfil e alteração de senha

## 💻 Rodando localmente

### Pré-requisitos
- Ruby 3.3.0
- Rails 7.1.5  
- PostgreSQL  
- Redis (para Sidekiq) 

### Passos
```bash
git clone git@github.com:thalytalima211/cinehub.git
cd cinehub
bundle install
rails db:create db:migrate db:seed
bin/dev
```

A aplicação ficará disponível em [http://localhost:3000](http://localhost:3000)

## ⚡ Sidekiq
Sidekiq é usado para processar tarefas em segundo plano, como a importação em massa de filmes via CSV. Para rodar localmente, é necessário ter o Redis ativo e iniciar o Sidekiq:
```bash
redis-server
bundle exec sidekiq
```
> Enquanto o Sidekiq estiver rodando, as tarefas agendadas no background serão processadas automaticamente.

## 📂 Formato CSV para importação
Para importar filmes em massa, a aplicação espera um arquivo CSV com as seguintes colunas:
```csv
title,description,release_year,duration,director,category
```
**Por exemplo:**
```csv
title,description,release_year,duration,director,category
O Grande Hotel Budapeste,Comédia dramática sobre um lendário hotel europeu,2014,99,Wes Anderson,Comédia
```
As categorias são pre-definidas no sistema, podendo ser:
- Ação
- Romance
- Comédia
- Drama
- Terror
- Suspense
- Fantasia
- Ficção Científica
- Animação
- Aventura
- Musical
- Documentário
- Biografia
- Histórico
- Policial

## 🛠 Ferramentas de Qualidade e Testes
- **RSpec + Factory Bot**
O projeto utiliza o RSpec para testes automatizados, garantindo que funcionalidades críticas funcionem conforme esperado. O Factory Bot é usado para criar objetos de teste de forma rápida e consistente, facilitando cenários de teste complexos em poucas linhas, garantindo a legibilidade dos testes.
- **SimpleCov (Coverage)**
O SimpleCov monitora a cobertura dos testes, mostrando quais linhas de código foram testadas e quais ainda precisam de testes. Isso ajuda a manter a qualidade do código e identificar partes não testadas.
- **RuboCop**
O RuboCop é utilizado como linter e ferramenta de análise estática, garantindo que o código siga as boas práticas do Ruby e do Rails, como estilo, convenções e padrões de código limpos.

## ✨ Observações
- **Envio de e-mails**: em desenvolvimento, o sistema envia notificações normalmente (como avisos de importação concluída).
- **Limitação em produção**: devido às restrições do Render quanto às portas do Gmail, o envio de e-mails não está disponível em produção, mas todas as outras funcionalidades estão plenamente operacionais.
