import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { DashbordComponent } from './components/dashbord/dashbord.component';
import { UsersComponent } from './components/users/users.component';
import { IsLoggedGuard } from './core/guard/is-logged.guard';

const routes: Routes = [
  {path: 'login', component: LoginComponent},
  {path: '', redirectTo: 'login', pathMatch: 'full'},
  {path: 'register', component: RegisterComponent},
  {path: 'dashbord', component: DashbordComponent, canActivate: [IsLoggedGuard]},
  {path: 'users', component: UsersComponent, canActivate: [IsLoggedGuard]}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
