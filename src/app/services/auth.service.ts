import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Compte } from '../models/compte';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  constructor(private http: HttpClient) { }

  login(username: string, password: string): Observable<any> {
    var data = new FormData();
    data.append('usernameOrEmailOrPhone', username);
    data.append('password', password)
    return this.http.post(environment.authApiUrl, data)
  }
}
