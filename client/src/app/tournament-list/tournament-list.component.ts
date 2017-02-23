import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-tournament-list',
  templateUrl: './tournament-list.component.html',
  styleUrls: ['./tournament-list.component.css']
})
export class TournamentListComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }


  tournaments: any[] = [
    {
      "Name" : "The Big Smackdown",
      "StartDate" : "3/4/2017",
      "EndDate" : "5/1/2017",
      "TeamSize" : 5,
      "TeamCount" : 10,
      "Username" : "derek"
    },
    {
      "Name" : "April Foolishness",
      "StartDate" : "4/1/2017",
      "EndDate" : "6/1/2017",
      "TeamSize" : 7,
      "TeamCount" : 3,
      "Username" : "michael"
    }
  ];

}
