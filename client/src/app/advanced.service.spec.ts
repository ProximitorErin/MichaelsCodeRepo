/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { AdvancedService } from './advanced.service';

describe('AdvancedService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [AdvancedService]
    });
  });

  it('should ...', inject([AdvancedService], (service: AdvancedService) => {
    expect(service).toBeTruthy();
  }));
});
