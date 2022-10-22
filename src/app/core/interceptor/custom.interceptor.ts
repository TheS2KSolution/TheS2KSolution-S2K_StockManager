import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HTTP_INTERCEPTORS
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth/auth.service';

@Injectable()
export class CustomInterceptor implements HttpInterceptor {

  constructor(private authService: AuthService) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    // Get the auth token from the service.
    const accessToken = this.authService.getAuthorizationToken();

    // Clone the request and replace the original headers with
    // cloned headers, updated with the authorization.
    const interceptRequest = request.clone({
      headers: request.headers.set('Authorization', 'Bearer '+accessToken)
    });

    // send cloned request with header to the next handler.
    return next.handle(interceptRequest);
  }
}

/** Http interceptor providers in outside-in order */
export const CustomInterceptorProviders = [
  { provide: HTTP_INTERCEPTORS,
    useClass: CustomInterceptor,
    multi: true
  },
];
