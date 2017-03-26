import { Component, OnInit } from '@angular/core';
import { AthletePerformanceService } from '../athlete-performance.service';
import { Observable } from 'rxjs/Observable';

@Component({
  selector: 'app-line-chart-demo-component',
  templateUrl: './line-chart-demo-component.component.html',
  styleUrls: ['./line-chart-demo-component.component.css']
})
export class LineChartDemoComponentComponent implements OnInit {

  constructor(private _performanceService: AthletePerformanceService) {
    _performanceService.charter = this;
   }

  ngOnInit() {
  }

  public lineChartData:Array<any>=[
    {"data":[0,1,0,2,0,0,0,0,0,1,0,2],"label":"assists"},
    {"data":[4,5,2,6,2,6,8,4,7,7,1,3],"label":"atBats"},
    {"data":[2,2,1,1,1,3,3,2,2,0,1,1],"label":"hits"},
    {"data":[0,0,0,0,0,3,2,0,2,2,0,1],"label":"leftonbase"},
    {"data":[5,3,2,2,3,2,5,5,5,2,2,2],"label":"putouts"},
    {"data":[1,2,1,1,0,2,3,0,1,0,2,1],"label":"rbis"},
    {"data":[1,1,0,1,0,1,2,1,1,0,1,0],"label":"runs"},
    {"data":[0,2,0,0,0,2,1,0,1,0,0,0],"label":"strikeouts"}
  ];

  public lineChartLabels:Array<any> = ['G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9', 'G10', 'G11', 'G12'];
  public lineChartOptions:any = {
    responsive: true
  };
  public lineChartColors:Array<any> = [
    { // grey
      backgroundColor: 'rgba(148,159,177,0.2)',
      borderColor: 'rgba(148,159,177,1)',
      pointBackgroundColor: 'rgba(148,159,177,1)',
      pointBorderColor: '#fff',
      pointHoverBackgroundColor: '#fff',
      pointHoverBorderColor: 'rgba(148,159,177,0.8)'
    },
    { // dark grey
      backgroundColor: 'rgba(77,83,96,0.2)',
      borderColor: 'rgba(77,83,96,1)',
      pointBackgroundColor: 'rgba(77,83,96,1)',
      pointBorderColor: '#fff',
      pointHoverBackgroundColor: '#fff',
      pointHoverBorderColor: 'rgba(77,83,96,1)'
    },
    { // grey
      backgroundColor: 'rgba(148,159,177,0.2)',
      borderColor: 'rgba(148,159,177,1)',
      pointBackgroundColor: 'rgba(148,159,177,1)',
      pointBorderColor: '#fff',
      pointHoverBackgroundColor: '#fff',
      pointHoverBorderColor: 'rgba(148,159,177,0.8)'
    }
  ];
  public lineChartLegend:boolean = true;
  public lineChartType:string = 'line';
  errorMessage: string;
  public holdMyBeer:Array<any>;

  public trySeparate(): void {

    this._performanceService.getAthleteStatsByDate(14)
                     .subscribe(
                       heroes => this.lineChartData = heroes,
                       error =>  this.errorMessage = <any>error);

    //this.lineChartData = this._performanceService.getAthleteStatsByDate(15);
  }
 
  public randomize():void {
    this._performanceService.getAthleteStatsByDate(14)
                     .subscribe(
                       heroes => this.lineChartData = heroes,
                       error =>  this.errorMessage = <any>error);
    /* let _lineChartData:Array<any> = new Array(this.lineChartData.length);
    for (let i = 0; i < this.lineChartData.length; i++) {
      _lineChartData[i] = {data: new Array(this.lineChartData[i].data.length), label: this.lineChartData[i].label};
      for (let j = 0; j < this.lineChartData[i].data.length; j++) {
        _lineChartData[i].data[j] = Math.floor((Math.random() * 100) + 1);
      }
    }
    this.lineChartData = _lineChartData;*/
  }
 
  // events
  public chartClicked(e:any):void {
    console.log(e);
  }
 
  public chartHovered(e:any):void {
    console.log(e);
  }

}
