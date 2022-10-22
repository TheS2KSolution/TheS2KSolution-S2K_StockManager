import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) { }

  getAuthorizationToken() {
    return localStorage.getItem('accessToken');
  }

  login(username: string, password: string) {
    var data = new FormData();
    data.append('usernameOrEmailOrPhone', username);
    data.append('password', password)
    return this.http.post(environment.authApiUrl, data).pipe(
      map((tokens: any) => {
        localStorage.setItem('accessToken', tokens['accessToken']);
        localStorage.setItem('refreshToken', tokens['refreshToken']);
      })
    );
  }
}
