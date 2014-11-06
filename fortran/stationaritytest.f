c     %# This is a program to calculate fluxes
c     %# Coded by Zhongwang Wei on 2014/11/05 @Tokyo Univ.
c    
      program stationaritytest

      implicit none

      integer :: i, j, k, m, n, num
      character*21 :: time, key
      real ::  data(12), sum1(7), sum2(7), sum3(7)
      real :: sum1w(7), sum2w(7), sum3w(7)

      real :: uu(6), vv(6), ww(6), tt(6), cc(6), qq(6)
      real :: uw(6), vw(6), wt(6), wc(6), wq(6)
      real :: uu_w, vv_w, ww_w, tt_w, cc_w, qq_w
      real :: uw_b, vw_b, wt_b, wc_b, wq_b
      real :: uw_w, vw_w, wt_w, wc_w, wq_w
      real :: RN_uw, RN_vw, RN_wt, RN_wc, RN_wq

      open(10,file='F:\kasumidata\2009\TBL_001/TBL001_200912.dat')
      open(20,file='stationaritytest.dat')

      m = 10*60*20
      n = 10*60*120
    
       key='2013-04-15 15:00:00.1'

      do i = 1, n*100000
     
   
      read(10,*) time
       if (time.eq.key) go to 100
       end do
      100 write(6,*) time


!!!!!!!!!!   DATA READING AND SUMMING UP   !!!!!!!!!!
	read(10,*)
	read(10,*)
	read(10,*)
	read(10,*)
      do i = 1, n*48*35*100000
        read(10,*) time, num, (data(j),j=1,7)
  
        if (mod(i,m).eq.1) then
            k = k + 1
          do j = 1, 7
            sum1(j) = 0.
            sum2(j) = 0.
            sum3(j) = 0.
          end do
        end if

        if (mod(i,n).eq.1) then
            k = 1
          do j = 1, 7
            sum1w(j) = 0.
            sum2w(j) = 0.
            sum3w(j) = 0.
          end do
        end if

        do j = 1, 7
          sum1(j) = sum1(j) + data(j)
          sum2(j) = sum2(j) + data(j)**2
          sum3(j) = sum3(j) + data(j)*data(3)

          sum1w(j) = sum1w(j) + data(j)
          sum2w(j) = sum2w(j) + data(j)**2
          sum3w(j) = sum3w(j) + data(j)*data(3)
        end do


!!!!!!!!!!  CALUCULATING CORRELATION   !!!!!!!!!!

        if( mod(i,m).eq.0 ) then
c          uu(k) = (m*sum2(1) - sum1(1)**2) / m**2
c          vv(k) = (m*sum2(2) - sum1(2)**2) / m**2
c          ww(k) = (m*sum2(3) - sum1(3)**2) / m**2
c          tt(k) = (m*sum2(4) - sum1(4)**2) / m**2
c          cc(k) = (m*sum2(5) - sum1(5)**2) / m**2
c          qq(k) = 0.018**2 * (m*sum2(6) - sum1(6)**2) / m**2

          uw(k) = (m*sum3(1) - sum1(1)*sum1(3)) / m**2
          vw(k) = (m*sum3(2) - sum1(2)*sum1(3)) / m**2
          wt(k) = (m*sum3(4) - sum1(4)*sum1(3)) / m**2
          wc(k) = (m*sum3(6) - sum1(6)*sum1(3)) / m**2
          wq(k) = 0.018 * (m*sum3(7) - sum1(7)*sum1(3)) / m**2
        end if

        if( mod(i,n).eq.0 ) then
c          uu_w = (n*sum2w(1) - sum1w(1)**2) / n**2
c          vv_w = (n*sum2w(2) - sum1w(2)**2) / n**2
c          ww_w = (n*sum2w(3) - sum1w(3)**2) / n**2
c          tt_w = (n*sum2w(4) - sum1w(4)**2) / n**2
c          cc_w = (n*sum2w(5) - sum1w(5)**2) / n**2
c          qq_w = 0.018**2 * (n*sum2w(6) - sum1w(6)**2) / n**2

          uw_w = (n*sum3w(1) - sum1w(1)*sum1w(3)) / n**2
          vw_w = (n*sum3w(2) - sum1w(2)*sum1w(3)) / n**2
          wt_w = (n*sum3w(4) - sum1w(4)*sum1w(3)) / n**2
          wc_w = (n*sum3w(6) - sum1w(6)*sum1w(3)) / n**2
          wq_w = 0.018 * (n*sum3w(7) - sum1w(7)*sum1w(3)) / n**2

          uw_b = ( uw(1)+uw(2)+uw(3)+uw(4)+uw(5)+uw(6) ) / 6
          vw_b = ( vw(1)+vw(2)+vw(3)+vw(4)+vw(5)+vw(6) ) / 6
          wt_b = ( wt(1)+wt(2)+wt(3)+wt(4)+wt(5)+wt(6) ) / 6
          wc_b = ( wc(1)+wc(2)+wc(3)+wc(4)+wc(5)+wc(6) ) / 6
          wq_b = ( wq(1)+wq(2)+wq(3)+wq(4)+wq(5)+wq(6) ) / 6

          RN_uw = abs( (uw_b - uw_w) / uw_w ) * 100.
          RN_vw = abs( (vw_b - vw_w) / vw_w ) * 100.
          RN_wt = abs( (wt_b - wt_w) / wt_w ) * 100.
          RN_wc = abs( (wc_b - wc_w) / wc_w ) * 100.
          RN_wq = abs( (wq_b - wq_w) / wq_w ) * 100.

          write(20,'(a21,2f15.6)') time, RN_uw, RN_vw
          if(mod(i,n*48).eq.0) write(6,*) time
        end if

      end do
      close(10)
      close(20)

      stop
      end program stationaritytest
