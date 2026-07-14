# Cine UP OS - Roteiro Supabase

Este roteiro cria a base compartilhada para que os dados deixem de ficar presos ao `localStorage` de cada celular.

## 1. Projeto

Projeto atual:

```txt
SUPABASE_URL=https://gmrnoizmttjqxamygbhi.supabase.co
SUPABASE_ANON_KEY=sb_publishable_dCxYGVnxYEyo_6wJ1foDZg_OGM581ac
```

Nunca compartilhe nem publique a `service_role key`.

## 2. Criar Tabelas

No Supabase:

1. Abra `SQL Editor`.
2. Cole o conteúdo de `supabase/cineup_schema_mvp.sql`.
3. Execute o script.
4. Depois cole e execute o conteúdo de `supabase/cineup_pendings_mvp_access.sql`.

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

## 3. Criar Buckets de Arquivos

Em `Storage`, crie estes buckets:

- `evidencias`
- `checklists`
- `achados-perdidos`
- `notas-fiscais`

Na primeira fase, vamos usar buckets privados e salvar caminhos nas tabelas.

## 4. Autenticação

Para o MVP sincronizado, há duas opções:

### Opção A - Mais rápida para teste

Criar logins por e-mail/senha no Supabase Auth e vincular esses usuários ao cadastro interno depois.

### Opção B - Mais parecida com o app atual

Manter login por nome/código/PIN no protótipo e usar permissões limitadas no banco.

Recomendação: começar pela opção A para não deixar o banco aberto.

## 5. Ordem Segura de Migração

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

## 6. Critério de Sucesso da Primeira Sprint

A primeira Sprint Supabase estará correta quando:

- um usuário criar pendência no celular A;
- outro usuário visualizar essa pendência no celular B;
- a liderança aprovar ou reprovar;
- ambos os celulares atualizarem o status;
- o dado continuar salvo após limpar cache ou trocar de aparelho.

## 7. Política Temporária do MVP

O arquivo `supabase/cineup_pendings_mvp_access.sql` libera leitura, criação e atualização de pendências usando a publishable key.

Isso é aceitável apenas para o protótipo interno. Quando ativarmos login real via Supabase Auth, essas políticas devem ser substituídas por regras por cargo, unidade e usuário.

## Observação

Hospedar no Netlify não sincroniza dados sozinho. O Netlify entrega o app. O Supabase será o banco compartilhado.
