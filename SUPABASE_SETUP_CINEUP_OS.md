# Cine UP OS - Roteiro Supabase

Este roteiro cria a base compartilhada para que os dados deixem de ficar presos ao `localStorage` de cada celular.

## 1. Criar o projeto

1. Acesse `https://supabase.com`.
2. Crie um projeto chamado `cine-up-os`.
3. Guarde:
   - `Project URL`
   - `anon public key`
4. Nunca compartilhe nem publique a `service_role key`.

## 2. Criar tabelas

No Supabase:

1. Abra `SQL Editor`.
2. Cole o conteúdo de `supabase/cineup_schema_mvp.sql`.
3. Execute o script.

Esse schema cria as tabelas principais do MVP:

- unidades;
- usuários internos;
- vínculo usuário x praça;
- tarefas;
- pendências;
- checklists;
- plano de chão;
- estoque;
- movimentações;
- rondas;
- ocorrências;
- achados e perdidos;
- progresso de treinamento.

## 3. Criar buckets de arquivos

Em `Storage`, crie estes buckets:

- `evidencias`
- `checklists`
- `achados-perdidos`
- `notas-fiscais`

Na primeira fase, vamos usar buckets privados e gerar caminhos salvos nas tabelas.

## 4. Configurar autenticação

Para o MVP sincronizado, há duas opções:

### Opção A - Mais rápida para teste

Criar logins por e-mail/senha no Supabase Auth e vincular esses usuários ao cadastro interno depois.

### Opção B - Mais parecida com o app atual

Manter login por nome/código/PIN no protótipo e usar uma credencial técnica limitada para sincronização.

Eu recomendo começar pela Opção A para não deixar o banco aberto.

## 5. Variáveis para Netlify

No painel do Netlify, configurar:

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

Se continuarmos no HTML único, podemos começar com configuração manual dentro do app, mas a versão correta é usar variáveis no build.

## 6. Ordem segura de migração

Não devemos migrar tudo de uma vez. A ordem recomendada é:

1. Pendências.
2. Checklists.
3. Plano de chão.
4. Rondas e ocorrências.
5. Achados e perdidos.
6. Estoque.
7. Ponto.
8. Relatórios.
9. Fotos e evidências reais.

## 7. Critério de sucesso da primeira Sprint

A primeira Sprint Supabase estará correta quando:

- um usuário criar pendência no celular A;
- outro usuário visualizar essa pendência no celular B;
- a liderança aprovar/reprovar;
- ambos os celulares atualizarem o status;
- o dado continuar salvo após limpar/cache/trocar aparelho.

## Observação importante

Hospedar no Netlify não sincroniza dados sozinho. O Netlify entrega o app. O Supabase será o banco compartilhado.
