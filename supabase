-- Cine UP OS - Supabase MVP
-- Execute este arquivo no SQL Editor do Supabase.
-- Objetivo: criar uma base compartilhada para substituir o localStorage por etapas.

create extension if not exists "pgcrypto";

create table if not exists public.locations (
  id text primary key,
  name text not null,
  short_name text not null,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.app_users (
  id text primary key,
  name text not null,
  role text not null check (role in ('director','manager','submanager','trainer','operator','finance','commercial','marketing','maintenance','admin')),
  pin_hash text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.user_locations (
  user_id text not null references public.app_users(id) on delete cascade,
  location_id text not null references public.locations(id) on delete cascade,
  primary key (user_id, location_id)
);

create table if not exists public.tasks (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  task_date date not null default current_date,
  title text not null,
  sector_id text,
  sector_name text,
  assigned_sector_id text,
  assignee_id text references public.app_users(id),
  status text not null default 'pending' check (status in ('pending','progress','submitted','approved','rejected','redo','reopened','done','expired','cancelled')),
  severity text not null default 'medium' check (severity in ('low','medium','high','critical')),
  due_date date,
  source text,
  note text,
  evidence_url text,
  created_by text references public.app_users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.pendings (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  pending_date date not null default current_date,
  title text not null,
  area text not null default 'Operação',
  status text not null default 'open' check (status in ('open','progress','waiting','submitted','approved','done','rejected','reopened','expired','cancelled')),
  severity text not null default 'medium' check (severity in ('low','medium','high','critical')),
  due_date date,
  assignee_id text references public.app_users(id),
  note text,
  action_note text,
  evidence_url text,
  source text default 'Manual',
  created_by text references public.app_users(id),
  approved_by text references public.app_users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.checklists (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  checklist_date date not null default current_date,
  round text not null,
  area_id text not null,
  area_name text not null,
  score integer not null default 0,
  items jsonb not null default '[]'::jsonb,
  created_by text references public.app_users(id),
  created_at timestamptz not null default now()
);

create table if not exists public.floor_plans (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  plan_date date not null default current_date,
  assignments jsonb not null default '{}'::jsonb,
  alerts jsonb not null default '[]'::jsonb,
  created_by text references public.app_users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.inventory_counts (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  count_date date not null default current_date,
  place text not null,
  items jsonb not null default '[]'::jsonb,
  created_by text references public.app_users(id),
  created_at timestamptz not null default now()
);

create table if not exists public.inventory_movements (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  movement_type text not null check (movement_type in ('entrada','saida','perda','transferencia','ajuste')),
  product_id text not null,
  qty numeric not null check (qty > 0),
  place_from text,
  place_to text,
  note text,
  created_by text references public.app_users(id),
  created_at timestamptz not null default now()
);

create table if not exists public.rounds (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  round_date date not null default current_date,
  location_name text not null,
  temperature numeric,
  status text not null default 'ok',
  note text,
  evidence_url text,
  created_by text references public.app_users(id),
  created_at timestamptz not null default now()
);

create table if not exists public.occurrences (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  occurrence_date date not null default current_date,
  title text not null,
  type text not null default 'Operação',
  severity text not null default 'medium' check (severity in ('low','medium','high','critical')),
  place text,
  note text,
  action text,
  follow_up boolean not null default false,
  evidence_url text,
  created_by text references public.app_users(id),
  created_at timestamptz not null default now()
);

create table if not exists public.lost_found (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  found_date date not null default current_date,
  item text not null,
  place text not null,
  seat text,
  session_label text,
  status text not null default 'stored' check (status in ('stored','returned','discarded')),
  photo_url text,
  note text,
  found_by text references public.app_users(id),
  returned_to_name text,
  returned_to_document text,
  returned_photo_url text,
  closed_by text references public.app_users(id),
  closed_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.training_progress (
  id text primary key,
  loc_id text not null references public.locations(id) on delete cascade,
  user_id text not null references public.app_users(id) on delete cascade,
  material_id text not null,
  status text not null default 'pending' check (status in ('pending','in_training','apt','blocked','done')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

insert into public.locations (id, name, short_name)
values
  ('mp', 'Cine UP Miguel Pereira', 'Miguel Pereira'),
  ('vas', 'Cine UP Vassouras', 'Vassouras')
on conflict (id) do nothing;

-- Segurança inicial para MVP:
-- Mantemos RLS ligada. Durante a primeira integração, as policies abaixo liberam acesso
-- apenas para usuários autenticados. Na etapa seguinte refinamos por praça/cargo.
alter table public.locations enable row level security;
alter table public.app_users enable row level security;
alter table public.user_locations enable row level security;
alter table public.tasks enable row level security;
alter table public.pendings enable row level security;
alter table public.checklists enable row level security;
alter table public.floor_plans enable row level security;
alter table public.inventory_counts enable row level security;
alter table public.inventory_movements enable row level security;
alter table public.rounds enable row level security;
alter table public.occurrences enable row level security;
alter table public.lost_found enable row level security;
alter table public.training_progress enable row level security;

do $$
declare
  tbl text;
begin
  foreach tbl in array array[
    'locations','app_users','user_locations','tasks','pendings','checklists','floor_plans',
    'inventory_counts','inventory_movements','rounds','occurrences','lost_found','training_progress'
  ]
  loop
    execute format('drop policy if exists "cineup_authenticated_select_%1$s" on public.%1$I', tbl);
    execute format('drop policy if exists "cineup_authenticated_insert_%1$s" on public.%1$I', tbl);
    execute format('drop policy if exists "cineup_authenticated_update_%1$s" on public.%1$I', tbl);
    execute format('create policy "cineup_authenticated_select_%1$s" on public.%1$I for select to authenticated using (true)', tbl);
    execute format('create policy "cineup_authenticated_insert_%1$s" on public.%1$I for insert to authenticated with check (true)', tbl);
    execute format('create policy "cineup_authenticated_update_%1$s" on public.%1$I for update to authenticated using (true) with check (true)', tbl);
  end loop;
end $$;

-- Buckets sugeridos em Storage:
-- evidencias
-- checklists
-- achados-perdidos
-- notas-fiscais
