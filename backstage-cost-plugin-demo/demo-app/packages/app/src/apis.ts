import {
  ScmIntegrationsApi,
  scmIntegrationsApiRef,
  ScmAuth,
} from '@backstage/integration-react';
import {
  AnyApiFactory,
  configApiRef,
  createApiFactory,
} from '@backstage/core-plugin-api';
// 👇 AGREGA ESTAS LÍNEAS - Importar Cost Insights
import { 
  costInsightsApiRef, 
  ExampleCostInsightsClient 
} from '@backstage-community/plugin-cost-insights';

export const apis: AnyApiFactory[] = [
  createApiFactory({
    api: scmIntegrationsApiRef,
    deps: { configApi: configApiRef },
    factory: ({ configApi }) => ScmIntegrationsApi.fromConfig(configApi),
  }),
  ScmAuth.createDefaultApiFactory(),
  // 👇 AGREGA ESTA CONFIGURACIÓN - Cost Insights con datos de ejemplo
  createApiFactory({
    api: costInsightsApiRef,
    deps: {},
    factory: () => new ExampleCostInsightsClient(),
  }),
];