import { Component, OnInit } from '@angular/core';
import { AdvancedService } from '../advanced.service';
import { Observable } from 'rxjs/Observable';
import { IAverageStat } from '../average-stat';


@Component({
  selector: 'app-current-sport-averages-list',
  templateUrl: './current-sport-averages-list.component.html',
  styleUrls: ['./current-sport-averages-list.component.css']
})
export class CurrentSportAveragesListComponent implements OnInit {

  constructor(private _advancedService : AdvancedService) {

   }

  ngOnInit() {
    this._advancedService.getSportAverages()
      .subscribe(
        stats => this.stats = stats,
        error => this.errorMessage = <any>error
      );
  }

  stats: IAverageStat[];
  errorMessage: string;

}
