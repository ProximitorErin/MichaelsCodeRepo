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

  // lineChart//
  public lineChartData:Array<any>=[
    {data: [65, 59, 80], label:'Series A'},
    {data: [28, 48, 40], label: 'Series B'},
    {data: [18, 48, 77], label: 'Series C'}
  ];

  public lineChartLabels:Array<any> = ['Game 1', 'Game 2', 'Game 3'];
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
 
  public randomize():void {
    //this.lineChartData = this._performanceService.getAthleteStatsByDate(15);
    let _lineChartData:Array<any> = new Array(this.lineChartData.length);
    for (let i = 0; i < this.lineChartData.length; i++) {
      _lineChartData[i] = {data: new Array(this.lineChartData[i].data.length), label: this.lineChartData[i].label};
      for (let j = 0; j < this.lineChartData[i].data.length; j++) {
        _lineChartData[i].data[j] = Math.floor((Math.random() * 100) + 1);
      }
    }
    this.lineChartData = _lineChartData;
  }
 
  // events
  public chartClicked(e:any):void {
    console.log(e);
  }
 
  public chartHovered(e:any):void {
    console.log(e);
  }

}
