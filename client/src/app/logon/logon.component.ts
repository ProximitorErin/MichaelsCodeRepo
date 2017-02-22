import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthenticationService } from '../authentication.service';

@Component({
  selector: 'app-logon',
  templateUrl: './logon.component.html',
  styleUrls: ['./logon.component.css']
})
export class LogonComponent implements OnInit {

  ngOnInit() {
  }

  constructor(private _router: Router, private _authService: AuthenticationService) { }

  username: string = '';
  password: string = '';

  redirect(): void
  {
    if (this._authService.getRole() == 'admin')
    {
      this._router.navigate(['administrator']);
    }
    //this.username = 'working';
  }

}
