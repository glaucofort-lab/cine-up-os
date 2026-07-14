-- Cine UP OS - sincronizacao geral do prototipo
-- Execute no SQL Editor depois dos scripts anteriores.
-- Esta tabela espelha todas as chaves localStorage cineup_* no Supabase.

create table if not exists public.app_state (
  key text primary key,
  value jsonb not null default 'null'::jsonb,
  updated_by text,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

drop policy if exists "cineup_anon_select_app_state" on public.app_state;
drop policy if exists "cineup_anon_insert_app_state" on public.app_state;
drop policy if exists "cineup_anon_update_app_state" on public.app_state;

create policy "cineup_anon_select_app_state"
on public.app_state for select to anon using (true);

create policy "cineup_anon_insert_app_state"
on public.app_state for insert to anon with check (true);

create policy "cineup_anon_update_app_state"
on public.app_state for update to anon using (true) with check (true);

create or replace function public.touch_app_state_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trg_touch_app_state_updated_at on public.app_state;
create trigger trg_touch_app_state_updated_at
before update on public.app_state
for each row execute function public.touch_app_state_updated_at();
