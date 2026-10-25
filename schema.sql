-- Aarohan Pocket 2.2: Run ONCE in your own Supabase project's SQL Editor.
-- Requires Supabase Auth; the application uses a PUBLIC anon/publishable key + signed-in user JWT.
-- NEVER put a service_role/secret key in an app, website or .env for Pocket.
CREATE TABLE IF NOT EXISTS public.pocket_items (
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  item_id text NOT NULL,
  item_type text NOT NULL CHECK (item_type IN ('card','brief')),
  payload jsonb NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY(user_id,item_id),
  CONSTRAINT pocket_item_length CHECK (length(item_id)<=120)
);
CREATE TABLE IF NOT EXISTS public.pocket_attempts (
  event_id uuid PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  card_id text NOT NULL,
  answer text NOT NULL,
  rating text NOT NULL CHECK (rating IN ('again','hard','good','easy')),
  mode text NOT NULL CHECK (mode IN ('recall','sentence','collocation','speak','mission')),
  performed_at timestamptz NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT pocket_answer_length CHECK (char_length(answer) BETWEEN 1 AND 1600)
);
CREATE INDEX IF NOT EXISTS pocket_attempt_user_time_idx ON public.pocket_attempts(user_id,performed_at);
ALTER TABLE public.pocket_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pocket_attempts ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.pocket_items FROM anon;
REVOKE ALL ON public.pocket_attempts FROM anon;
GRANT SELECT,INSERT,UPDATE ON public.pocket_items TO authenticated;
GRANT SELECT,INSERT ON public.pocket_attempts TO authenticated;
DROP POLICY IF EXISTS pocket_items_read ON public.pocket_items;
DROP POLICY IF EXISTS pocket_items_insert ON public.pocket_items;
DROP POLICY IF EXISTS pocket_items_update ON public.pocket_items;
DROP POLICY IF EXISTS pocket_attempts_read ON public.pocket_attempts;
DROP POLICY IF EXISTS pocket_attempts_insert ON public.pocket_attempts;
CREATE POLICY pocket_items_read ON public.pocket_items FOR SELECT TO authenticated
  USING ((SELECT auth.uid())=user_id);
CREATE POLICY pocket_items_insert ON public.pocket_items FOR INSERT TO authenticated
  WITH CHECK ((SELECT auth.uid())=user_id);
CREATE POLICY pocket_items_update ON public.pocket_items FOR UPDATE TO authenticated
  USING ((SELECT auth.uid())=user_id) WITH CHECK ((SELECT auth.uid())=user_id);
CREATE POLICY pocket_attempts_read ON public.pocket_attempts FOR SELECT TO authenticated
  USING ((SELECT auth.uid())=user_id);
CREATE POLICY pocket_attempts_insert ON public.pocket_attempts FOR INSERT TO authenticated
  WITH CHECK ((SELECT auth.uid())=user_id);
