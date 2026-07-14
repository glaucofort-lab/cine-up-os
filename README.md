# Cine UP OS

Protótipo operacional mobile-first da Rede Cine UP.

## Estado atual

- App em HTML único para prototipação funcional.
- Hospedagem recomendada: Netlify.
- Sincronização em implantação: Supabase.
- Uso atual: operação diária, pendências, checklists, plano de chão, estoque, rondas, ocorrências, POPs e treinamentos.

## Arquivos principais

- `index.html`: entrada principal para hospedagem.
- `cine-up-os.html`: cópia operacional do protótipo.
- `supabase/cineup_schema_mvp.sql`: schema inicial do Supabase.
- `SUPABASE_SETUP_CINEUP_OS.md`: roteiro de configuração do Supabase.
- `SUPABASE_PROJECT_INFO.md`: informações identificadas do projeto Supabase.

## Supabase

Projeto identificado:

```txt
SUPABASE_URL=https://gmrnoizmttjqxamygbhi.supabase.co
```

Ainda falta configurar no app:

```txt
SUPABASE_ANON_KEY=cole_a_anon_public_key_aqui
```

Não publicar a `service_role key`.

## Netlify

Para publicar:

1. Conectar este repositório ao Netlify.
2. Publicar a raiz do repositório.
3. Usar `index.html` como app principal.
4. Quando a integração Supabase estiver pronta, configurar as variáveis:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`

## Observação

O app ainda preserva o `localStorage` como fallback do protótipo. A migração para Supabase deve ser feita por etapas, começando por pendências, checklist e plano de chão.
