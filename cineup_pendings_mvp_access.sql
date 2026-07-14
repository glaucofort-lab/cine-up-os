-- Cine UP OS - acesso temporario para MVP de pendencias
-- Execute depois de supabase/cineup_schema_mvp.sql.
-- Objetivo: permitir o primeiro teste real entre celulares usando a publishable key.
-- Revisar e endurecer estas politicas quando o login real via Supabase Auth entrar.

insert into public.locations (id, name, short_name)
values
  ('mp', 'Cine UP Miguel Pereira', 'Miguel Pereira'),
  ('vas', 'Cine UP Vassouras', 'Vassouras'),
  ('val', 'Cine UP Valenca', 'Valenca')
on conflict (id) do update
set name = excluded.name,
    short_name = excluded.short_name,
    active = true;

insert into public.app_users (id, name, role)
values
  ('glauco','Glauco Fort','director'),
  ('gustavo_fort','Gustavo Fort','director'),
  ('gustavo','Gustavo','submanager'),
  ('paulo','Paulo','trainer'),
  ('davi','Davi','operator'),
  ('lucas','Lucas','operator'),
  ('lorran','Lorran','operator'),
  ('tassia','Tassia','operator'),
  ('manoel','Manoel','operator'),
  ('douglas','Douglas','operator'),
  ('sergio','Sergio','operator'),
  ('vitor','Vitor','operator'),
  ('maraiza','Maraiza','manager'),
  ('dandara','Dandara','operator'),
  ('thaissa','Thaissa','operator'),
  ('vinicius','Vinicius','operator'),
  ('luis','Luis','operator'),
  ('caio','Caio','operator')
on conflict (id) do update
set name = excluded.name,
    role = excluded.role,
    active = true;

insert into public.user_locations (user_id, location_id)
values
  ('glauco','mp'),('glauco','val'),('glauco','vas'),
  ('gustavo_fort','mp'),('gustavo_fort','val'),('gustavo_fort','vas'),
  ('gustavo','mp'),('paulo','mp'),('davi','mp'),('lucas','mp'),('lorran','mp'),('tassia','mp'),
  ('vinicius','mp'),('luis','mp'),('caio','mp'),
  ('manoel','val'),('douglas','val'),('sergio','val'),('vitor','val'),
  ('maraiza','vas'),('dandara','vas'),('thaissa','vas')
on conflict (user_id, location_id) do nothing;

drop policy if exists "cineup_anon_select_locations" on public.locations;
drop policy if exists "cineup_anon_select_app_users" on public.app_users;
drop policy if exists "cineup_anon_select_user_locations" on public.user_locations;
drop policy if exists "cineup_anon_select_pendings" on public.pendings;
drop policy if exists "cineup_anon_insert_pendings" on public.pendings;
drop policy if exists "cineup_anon_update_pendings" on public.pendings;

create policy "cineup_anon_select_locations"
on public.locations for select to anon using (true);

create policy "cineup_anon_select_app_users"
on public.app_users for select to anon using (true);

create policy "cineup_anon_select_user_locations"
on public.user_locations for select to anon using (true);

create policy "cineup_anon_select_pendings"
on public.pendings for select to anon using (true);

create policy "cineup_anon_insert_pendings"
on public.pendings for insert to anon with check (true);

create policy "cineup_anon_update_pendings"
on public.pendings for update to anon using (true) with check (true);
