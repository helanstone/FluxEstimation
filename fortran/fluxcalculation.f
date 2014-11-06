c     %# This is a program to calculate fluxes
c     %# Coded by Zhongwang Wei on 2014/11/02 @Tokyo Univ.
c     %# Modified by Zhongwang Wei on 2014/11/04 @Tokyo Univ.

      program fluxcalculation

      implicit none

      integer :: i, j, n, x
      character*21 :: time, key
      parameter (n=17999)
c	parameter (n=18000)

      real :: num, data(12), sum1(7), sum2(7), sum3(7)
      real :: uu, vv, ww, tt, cc, qq
      real :: uw, vw, tw, cw, qw
      real :: T, e, q, r, Cp_r, Lv
      real :: u_star, H, LE, C

c    
      open(10,file='C:\Users\wei\Desktop\New folder\3.dat')
      open(20,file='fluxcalculation.dat')

c      key='2013-04-15 15:00:00  '
      key='2013-04-15 15:00:00.1'

      do i = 1, n*100
        read(10,*) time
        if (time.eq.key) go to 100
      end do

  100 write(6,*) time
        do j = 1, 7
          sum1(j) = 0.
          sum2(j) = 0.
          sum3(j) = 0.
        end do

      do i = 1, n*48*7
        read(10,*) time, num, (data(x),x=1,12)

c        if (i.le.300) write(20,'(5f8.3,2f10.5)') i/10., (data(x),x=1,6)
	data(6)=data(6)/44.
	data(7)=data(7)*1000./18.
        do j = 1, 7
          sum1(j) = sum1(j) + data(j)
          sum2(j) = sum2(j) + data(j)**2
          sum3(j) = sum3(j) + data(j)*data(3)
        end do

        if( mod(i,n).eq.0 ) then
          uu = (n*sum2(1) - sum1(1)**2) / n**2
          vv = (n*sum2(2) - sum1(2)**2) / n**2
          ww = (n*sum2(3) - sum1(3)**2) / n**2
          tt = (n*sum2(4) - sum1(4)**2) / n**2
          cc = (n*sum2(6) - sum1(6)**2) / n**2
          qq = 0.018**2 * (n*sum2(7) - sum1(7)**2) / n**2

          uw = (n*sum3(1) - sum1(1)*sum1(3)) / n**2
          vw = (n*sum3(2) - sum1(2)*sum1(3)) / n**2
          tw = (n*sum3(4) - sum1(4)*sum1(3)) / n**2
          cw = (n*sum3(6) - sum1(6)*sum1(3)) / n**2
          qw = 0.018 * (n*sum3(7) - sum1(7)*sum1(3)) / n**2

          T = data(4) + 273.15   ! [K]
          q = data(7) * 18 * 10.**(-6)   ! [kg/m3]
          e = q * T / 0.2167   ! [hPa]
          r = 1.293 * 273.15/T * (1013.25 - 0.378*e) / 1013.25   ! [kg/m3]
          Cp_r = 1005. * (r + 0.84*q)   ! [J/m3/K]
          Lv = 3151.05 - 2.37839*T   ! [J/kg]

          u_star = (uw**2 + vw**2) ** (1./4)
          H = Cp_r * tw
          LE = Lv * qw
          C = 1000. * cw

          write(20,'(a21,15f12.6)') time, uu, vv, ww, tt, cc, qq,
     &     uw, vw, tw, cw, qw, u_star, H, LE, C
          write(6,*) i/n

          do j = 1, 7
            sum1(j) = 0.
            sum2(j) = 0.
            sum3(j) = 0.
          end do
        end if

      end do

      close(10)
      close(20)

      stop
      end program fluxcalculation
