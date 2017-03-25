/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { AthletePerformanceService } from './athlete-performance.service';

describe('AthletePerformanceService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [AthletePerformanceService]
    });
  });

  it('should ...', inject([AthletePerformanceService], (service: AthletePerformanceService) => {
    expect(service).toBeTruthy();
  }));
});
