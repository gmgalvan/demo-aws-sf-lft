import {
  CostInsightsApi,
  Cost,
  Entity,
  Group,
  MetricData,
  Alert,
  Project,
  ProductInsightsOptions,
  DEFAULT_DATE_FORMAT,
} from '@backstage-community/plugin-cost-insights';
import { DateTime } from 'luxon';

export class AwsMockCostInsightsClient implements CostInsightsApi {
  private getLastNDays(n: number): string[] {
    const days: string[] = [];
    for (let i = n; i >= 0; i--) {
      days.push(
        DateTime.now()
          .minus({ days: i })
          .toFormat(DEFAULT_DATE_FORMAT),
      );
    }
    return days;
  }

  private generateRandomCost(base: number, variance: number): number {
    return Math.round(base + (Math.random() - 0.5) * variance);
  }

  async getUserGroups(userId: string): Promise<Group[]> {
    return [
      {
        id: 'group-a',
        name: 'Team A',
      },
      {
        id: 'group-b',
        name: 'Team B',
      },
    ];
  }

  async getGroupProjects(group: string): Promise<Project[]> {
    return [
      {
        id: 'project-1',
        name: 'Production Environment',
      },
      {
        id: 'project-2',
        name: 'Development Environment',
      },
    ];
  }

  async getAlerts(group: string): Promise<Alert[]> {
    return [
      {
        title: 'Unexpected EC2 Cost Increase',
        subtitle: 'EC2 costs increased by 45% this week',
        url: '/cost-insights',
        buttonText: 'View Details',
        element: null,
      },
      {
        title: 'S3 Storage Optimization',
        subtitle: 'Consider moving to S3 Glacier for cold data',
        url: '/cost-insights',
        buttonText: 'Learn More',
        element: null,
      },
    ];
  }

  async getLastCompleteBillingDate(): Promise<string> {
    return DateTime.now().minus({ days: 1 }).toFormat(DEFAULT_DATE_FORMAT);
  }

  async getProjectDailyCost(project: string, intervals: string): Promise<Cost> {
    const days = this.getLastNDays(60);
    const aggregation: number[] = days.map(() =>
      this.generateRandomCost(15000, 3000),
    );

    return {
      id: project,
      aggregation: aggregation,
      change: {
        ratio: 0.23,
        amount: 2500,
      },
      trendline: {
        slope: 150,
        intercept: 12000,
      },
    };
  }

  async getGroupDailyCost(group: string, intervals: string): Promise<Cost> {
    const days = this.getLastNDays(90);
    const aggregation: number[] = days.map(() =>
      this.generateRandomCost(45000, 8000),
    );

    return {
      id: group,
      aggregation: aggregation,
      change: {
        ratio: 0.18,
        amount: 7200,
      },
      trendline: {
        slope: 320,
        intercept: 38000,
      },
    };
  }

  async getDailyMetricData(
    metric: string,
    intervals: string,
  ): Promise<MetricData> {
    const days = this.getLastNDays(90);
    const values: number[] = days.map(() =>
      this.generateRandomCost(50000, 10000),
    );

    return {
      id: metric,
      format: 'number',
      aggregation: values,
      change: {
        ratio: 0.15,
        amount: 7500,
      },
    };
  }

  async getProjectGrowth(
    project: string,
    intervals: string,
  ): Promise<{ [x: string]: Cost }> {
    return {
      ec2: {
        id: 'ec2',
        aggregation: [5000, 5200, 5500, 6000, 6200],
        change: {
          ratio: 0.24,
          amount: 1200,
        },
      },
      s3: {
        id: 's3',
        aggregation: [2000, 2100, 2050, 2200, 2300],
        change: {
          ratio: 0.15,
          amount: 300,
        },
      },
      rds: {
        id: 'rds',
        aggregation: [3500, 3600, 3700, 3800, 3900],
        change: {
          ratio: 0.11,
          amount: 400,
        },
      },
      lambda: {
        id: 'lambda',
        aggregation: [800, 850, 900, 950, 1000],
        change: {
          ratio: 0.25,
          amount: 200,
        },
      },
    };
  }

  async getProductInsights(options: ProductInsightsOptions): Promise<Entity> {
    const { product, intervals, project } = options;
    const days = this.getLastNDays(60);

    // Generar datos según el producto AWS
    const baseValues: Record<string, { base: number; variance: number }> = {
      ec2: { base: 8000, variance: 1500 },
      s3: { base: 3000, variance: 600 },
      rds: { base: 5500, variance: 1000 },
      lambda: { base: 1200, variance: 300 },
    };

    const productData = baseValues[product] || { base: 5000, variance: 1000 };

    const aggregation = days.map(() =>
      this.generateRandomCost(productData.base, productData.variance),
    );

    // Datos de ejemplo para entidades (recursos específicos)
    const entities: Record<string, any> = {
      ec2: [
        {
          id: 'i-0abc123def456',
          aggregation: days.map(() => this.generateRandomCost(2500, 500)),
          entities: {},
          change: { ratio: 0.15, amount: 375 },
        },
        {
          id: 'i-0xyz789ghi012',
          aggregation: days.map(() => this.generateRandomCost(3000, 600)),
          entities: {},
          change: { ratio: 0.22, amount: 660 },
        },
      ],
      s3: [
        {
          id: 'my-app-assets-bucket',
          aggregation: days.map(() => this.generateRandomCost(1200, 200)),
          entities: {},
          change: { ratio: 0.08, amount: 96 },
        },
        {
          id: 'my-app-logs-bucket',
          aggregation: days.map(() => this.generateRandomCost(800, 150)),
          entities: {},
          change: { ratio: 0.18, amount: 144 },
        },
      ],
      rds: [
        {
          id: 'prod-postgres-db',
          aggregation: days.map(() => this.generateRandomCost(3500, 700)),
          entities: {},
          change: { ratio: 0.12, amount: 420 },
        },
      ],
      lambda: [
        {
          id: 'api-handler-function',
          aggregation: days.map(() => this.generateRandomCost(400, 80)),
          entities: {},
          change: { ratio: 0.25, amount: 100 },
        },
        {
          id: 'data-processor-function',
          aggregation: days.map(() => this.generateRandomCost(600, 120)),
          entities: {},
          change: { ratio: 0.30, amount: 180 },
        },
      ],
    };

    return {
      id: product,
      aggregation: aggregation,
      change: {
        ratio: 0.18,
        amount: Math.round(productData.base * 0.18),
      },
      entities: entities[product] || [],
    };
  }

  async getCatalogEntityDailyCost(
    catalogEntityRef: string,
    intervals: string,
  ): Promise<Cost> {
    const days = this.getLastNDays(30);
    const aggregation: number[] = days.map(() =>
      this.generateRandomCost(8000, 1500),
    );

    return {
      id: catalogEntityRef,
      aggregation: aggregation,
      change: {
        ratio: 0.16,
        amount: 1280,
      },
      trendline: {
        slope: 100,
        intercept: 7000,
      },
    };
  }

  async getCatalogEntityProducts(
    catalogEntityRef: string,
    intervals: string,
  ): Promise<Entity> {
    const days = this.getLastNDays(30);

    return {
      id: catalogEntityRef,
      entities: [
        {
          id: 'ec2',
          aggregation: days.map(() => this.generateRandomCost(3500, 700)),
          change: { ratio: 0.20, amount: 700 },
          entities: {},
        },
        {
          id: 's3',
          aggregation: days.map(() => this.generateRandomCost(1500, 300)),
          change: { ratio: 0.12, amount: 180 },
          entities: {},
        },
        {
          id: 'rds',
          aggregation: days.map(() => this.generateRandomCost(2500, 500)),
          change: { ratio: 0.15, amount: 375 },
          entities: {},
        },
      ],
    };
  }
}