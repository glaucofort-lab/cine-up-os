# Supabase - Cine UP OS

Projeto identificado:

- Nome: `Aplicativo Rede Cine UP`
- Status: saudável
- Região: São Paulo
- Project URL: `https://gmrnoizmttjqxamygbhi.supabase.co`
- Publishable key: `sb_publishable_dCxYGVnxYEyo_6wJ1foDZg_OGM581ac`
- Schema esperado: `supabase/cineup_schema_mvp.sql`

## Status da Conexão

O protótipo já possui a configuração pública inicial dentro do HTML:

- `SUPABASE_CONFIG.url`
- `SUPABASE_CONFIG.anonKey`
- `supabaseClient`

Nesta etapa, o app continua usando `localStorage` como fallback. A sincronização com o Supabase deve ser ativada por módulo, começando por pendências, checklist e plano de chão.

## Próximo Passo

Execute o arquivo `supabase/cineup_schema_mvp.sql` no SQL Editor do Supabase.

Depois disso, podemos implementar a primeira sincronização real:

1. Pendências.
2. Checklists.
3. Plano de chão.

## Segurança

Não publicar nem compartilhar:

- `service_role key`;
- senha do banco;
- token privado;
- credenciais pessoais.

A publishable key pode ficar no frontend, desde que as permissões do banco estejam corretamente configuradas.
