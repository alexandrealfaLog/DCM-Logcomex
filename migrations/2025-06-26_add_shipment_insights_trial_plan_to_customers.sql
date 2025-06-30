-- ========================================
-- Autor: Alexandre Alfa
-- Database: db_api
-- Data: 2025-06-26
-- Objetivo: Inserir plano trial do produto shipment insights aos customers que tem o plataformabi ativo e não tem nenhum plano do shipment insights contratado ou em trial ativo.
-- Produto: Service ID 44 (Shipment Insights)
-- Impacto estimado: ~500 linhas em customer_plan
-- Riscos: Evitar duplicidade de planos já ativos
-- ========================================

INSERT INTO public.customer_plan (
    customer_id,
    plan_complete_id,
    plan_info_id,
    expiration,
    created_at,
    updated_at,
    deleted_at,
    start,
    tracking_plan_info_id,
    trial_start,
    trial_end,
    restrict_period,
    restriction_start,
    restriction_end,
    plan_submodule_id
)
SELECT
    c.id AS customer_id,
    2475,                -- plan_complete_id do plano shipment insights PLG
    35140,               -- plan_info_id correspondente
    NULL,
    NOW(),
    NOW(),
    NULL,
    NULL,
    NULL,
    NOW(),               -- trial_start
    NOW() + INTERVAL '15 days', -- trial_end
    FALSE,
    NULL,
    NULL,
    NULL
FROM customer c
JOIN customer_plan cp ON c.id = cp.customer_id
JOIN plan_complete pc ON cp.plan_complete_id = pc.id
JOIN plan_info pi ON pc.plan_info_id = pi.id
WHERE c.fake_customer = FALSE
  AND pc.deleted_at IS NULL
  AND pc.plan_submodule_id = 54 -- submodulo do plataforma bi
  AND c.deleted_at IS NULL
  AND cp.deleted_at IS NULL
  AND cp.expiration > NOW()
  AND NOT EXISTS (
    SELECT 1
    FROM customer_plan cp_inner
    JOIN plan_complete pc_inner ON cp_inner.plan_complete_id = pc_inner.id
    WHERE cp_inner.customer_id = c.id
      AND pc_inner.service_id = 44 -- service_id do shipment insights
      AND cp_inner.deleted_at IS NULL
      AND (cp_inner.trial_end > NOW() OR cp_inner.expiration > NOW())
  );
