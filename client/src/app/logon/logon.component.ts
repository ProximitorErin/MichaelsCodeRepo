import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-logon',
  templateUrl: './logon.component.html',
  styleUrls: ['./logon.component.css']
})
export class LogonComponent implements OnInit {

  ngOnInit() {
  }

  constructor(private _router: Router) { }

  username: string = '';
  password: string = '';

  redirect(): void
  {
    this._router.navigate(['administrator']);
    //this.username = 'working';
  }

}
