# Cine UP OS - Roteiro Supabase

Este roteiro cria a base compartilhada para que os dados deixem de ficar presos ao `localStorage` de cada celular.

## 1. Projeto

Projeto atual:

```txt
SUPABASE_URL=https://gmrnoizmttjqxamygbhi.supabase.co
SUPABASE_ANON_KEY=sb_publishable_dCxYGVnxYEyo_6wJ1foDZg_OGM581ac
```

Nunca compartilhe nem publique a `service_role key`.

## 2. Scripts SQL

Execute no Supabase SQL Editor, nesta ordem:

1. `supabase/cineup_schema_mvp.sql`
2. `supabase/cineup_pendings_mvp_access.sql`
3. `supabase/cineup_app_state_mvp.sql`

O terceiro script cria a tabela `app_state`, usada para espelhar todas as chaves `cineup_*` do protótipo.

## 3. Modelo de Sincronização Atual

Nesta fase, o app usa dois caminhos:

- tabelas específicas para módulos já iniciados, como `pendings`;
- tabela geral `app_state` para sincronizar todo o restante do protótipo sem reescrever cada módulo agora.

O `localStorage` continua como fallback local. Quando o Supabase estiver disponível, o app:

- baixa o estado remoto na abertura;
- grava cada alteração local também no Supabase;
- recarrega uma vez se encontrar dados remotos mais recentes.

## 4. Buckets de Arquivos

Em `Storage`, crie estes buckets quando começarmos fotos reais:

- `evidencias`
- `checklists`
- `achados-perdidos`
- `notas-fiscais`

Na fase atual, fotos ainda são evidências simuladas/textuais no protótipo.

## 5. Segurança

As políticas atuais liberam acesso com a publishable key para viabilizar o teste interno do protótipo.

Antes de uso definitivo:

- ativar login real via Supabase Auth;
- trocar políticas abertas por regras por cargo, unidade e usuário;
- revisar buckets privados;
- criar trilha de auditoria para ações críticas.

## 6. Critério de Sucesso

A migração geral estará correta quando:

- um usuário criar ou alterar dados em um celular;
- outro usuário visualizar os mesmos dados em outro aparelho;
- as alterações permanecerem salvas após limpar cache ou trocar de dispositivo;
- pendências, checklists, plano de chão, estoque e demais registros preservarem estado compartilhado.
