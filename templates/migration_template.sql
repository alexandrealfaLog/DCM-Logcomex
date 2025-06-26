-- ========================================
-- Autor: Alexandre Alfa
-- Database: db-api
-- Data: 2025-06-26
-- Objetivo: Inserir plano trial do produto X
-- Produto: Service ID 44 (nome do serviço)
-- Impacto estimado: ~500 linhas em customer_plan
-- Riscos: Evitar duplicidade de planos já ativos
-- ========================================

-- 👇 QUERY SEGURA E TESTADA ABAIXO
INSERT INTO public.customer_plan (
  customer_id, plan_complete_id, plan_info_id, expiration,
  created_at, updated_at, deleted_at, start, tracking_plan_info_id,
  trial_start, trial_end, restrict_period, restriction_start,
  restriction_end, plan_submodule_id
)
SELECT ...
