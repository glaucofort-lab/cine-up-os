# Cine UP OS

Protótipo operacional mobile-first da Rede Cine UP.

## Estado Atual

- App em HTML único para prototipação funcional.
- Hospedagem recomendada: Netlify.
- Sincronização em implantação: Supabase.
- Uso atual: operação diária, pendências, checklists, plano de chão, estoque, rondas, ocorrências, POPs e treinamentos.

## Arquivos Principais

- `index.html`: entrada principal para hospedagem.
- `cine-up-os.html`: cópia operacional do protótipo.
- `assets/`: logos e imagens usadas pelo app.
- `supabase/cineup_schema_mvp.sql`: schema inicial do Supabase.
- `supabase/cineup_pendings_mvp_access.sql`: políticas temporárias para testar pendências sincronizadas.
- `SUPABASE_SETUP_CINEUP_OS.md`: roteiro de configuração do Supabase.
- `SUPABASE_PROJECT_INFO.md`: informações identificadas do projeto Supabase.

## Supabase

Projeto configurado:

```txt
SUPABASE_URL=https://gmrnoizmttjqxamygbhi.supabase.co
SUPABASE_ANON_KEY=sb_publishable_dCxYGVnxYEyo_6wJ1foDZg_OGM581ac
```

Não publicar a `service_role key`.

O app ainda preserva o `localStorage` como fallback do protótipo. A migração para Supabase começou por pendências e deve seguir depois para checklist e plano de chão.

## Netlify

Para publicar:

1. Conectar este repositório ao Netlify.
2. Usar `index.html` como app principal.
3. Configurar domínio e HTTPS.
4. Depois da primeira sincronização real, revisar as permissões das tabelas no Supabase.

## Próxima Sprint

Ativar a sincronização real das pendências para validar o fluxo:

- celular A cria uma pendência;
- celular B visualiza a pendência;
- liderança aprova ou reprova;
- ambos visualizam o mesmo status.
