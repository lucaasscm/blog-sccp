# Blog Sempre Altaneiro

**[blog-sempre-altaneiro.live](https://blog-sempre-altaneiro.live)**

Um blog simples construído do zero — do código à produção — como campo de treino para dois objetivos: explorar o workflow de desenvolvimento com IA (Claude Code) e aprender na prática como subir uma aplicação Rails em um servidor real.

## Motivação

Este projeto não nasceu para resolver um problema de negócio. Ele existe para responder duas perguntas:

1. **Como é desenvolver com IA como par?** — Toda a base do projeto foi construída em pair programming com Claude Code, testando os limites do que funciona, o que atrapalha e como manter o controle do código.
2. **Como vai de zero a produção?** — Containerização, deploy automatizado, SSL, domínio, reverse proxy: tudo configurado manualmente para entender o que acontece embaixo do capô.

## Stack

- **Rails 8** — framework principal
- **SQLite + Solid Trifecta** — banco, cache, filas e websockets sem Redis
- **Hotwire** (Turbo + Stimulus) — reatividade sem SPA
- **Tailwind CSS 4** — estilização
- **Cloudflare R2** — armazenamento de arquivos
- **Kamal** — deploy via Docker em VPS Oracle

## Funcionalidades

- Publicação de posts com categorias e tags
- Sistema de comentários
- Painel admin para moderação de conteúdo
- Autenticação nativa (sem devise)

## Rodando localmente

```bash
bundle install
bin/rails db:setup
bin/dev
```

A aplicação sobe em `http://localhost:3000`.

## Deploy

O deploy é feito via [Kamal](https://kamal-deploy.org) em uma VPS Oracle:

```bash
kamal deploy
```
