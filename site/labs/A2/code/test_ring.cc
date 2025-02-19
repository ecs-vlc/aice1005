#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"

#include "ring.h"

TEST_CASE("Test Ring") {
  Ring<int> ring;

  SUBCASE("Check constructor") {
    CHECK(ring.size()==0);
    CHECK(ring.capacity()==8);
  }

  SUBCASE("Check adding and indexing") {
    ring.add(5);
    CHECK(ring.size()==1);
    CHECK(ring.capacity()==8);
 
    CHECK(ring[0]==5);
  }

  SUBCASE("Check set capacity") {
    Ring<int> ring1(12);
    for(int i=0; i<10; ++i) {
      ring1.add(i);
    }
    CHECK(ring1.size()==10);
    CHECK(ring1.capacity()==12);

    CHECK(ring1[0]==9);
    CHECK(ring1[10]==0);
  }

  SUBCASE("Check multiple adds") {
    for(int i=0; i<10; ++i) {
      ring.add(i);
    }
    CHECK(ring[0]==9);
    CHECK(ring[8]==2);

    CHECK_THROWS(ring[10]);
  }
  
  SUBCASE("Copy constructor") {
    ring.add(3);
    ring.add(4);
    CHECK(ring.size()==2);

    Ring<int> ring2(ring);
    CHECK(ring2[0]==4);
    ring2.add(5);
    CHECK(ring2[0]==5);
    CHECK_MESSAGE(ring.size()==2, "should be a deep copy");
    ring2.add(6);
    CHECK(ring2[0]==6);
    CHECK(ring2[3]==3);

    CHECK(ring[1]==3);
    CHECK(ring[2]==4);
  }

  SUBCASE("test iterator") {
    for(int i=0; i<10; ++i) {
      ring.add(i);
    }

    int cnt = 0;
    for(auto ring_pt=ring.begin(); ring_pt!=ring.end(); ++ring_pt) {
      CHECK(*ring_pt==8-cnt);
      ++cnt;
    }
    CHECK(cnt==8);

    // the next one should work by default
    cnt = 0;
    for(int item: ring) {
      CHECK(item==8-cnt);
    }
    CHECK(cnt==8);
  }
}
