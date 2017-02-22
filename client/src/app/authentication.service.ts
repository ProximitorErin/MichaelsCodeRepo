import { Injectable } from '@angular/core';

@Injectable()
export class AuthenticationService {

  constructor() { }

  getRole() : string
  {
    return "admin";
  }

}
