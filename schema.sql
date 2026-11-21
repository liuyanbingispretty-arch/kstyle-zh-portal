-- 在 Supabase SQL Editor 中运行，用于每人独立保存自己的收藏。
create table if not exists public.bookmarks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 100),
  url text not null check (char_length(url) between 1 and 2048),
  created_at timestamptz not null default now()
);
create index if not exists bookmarks_user_idx on public.bookmarks(user_id);
create unique index if not exists bookmarks_user_url_unique on public.bookmarks(user_id, url);
alter table public.bookmarks enable row level security;
drop policy if exists "bookmark owner only" on public.bookmarks;
create policy "bookmark owner only" on public.bookmarks
  for all to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
